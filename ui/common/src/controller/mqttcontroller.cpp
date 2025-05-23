/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "mqttcontroller.h"

#include <QtConcurrent>

#include "common/src/topics/topics.h"
#include "common/src/utils/logger.h"

MqttController::MqttController(QObject *parent)
    : QObject(parent)
    , _senderRunning(true)
{
    this->_qMqttClient = new QMqttClient(this);
    this->_qMqttClient->setAutoKeepAlive(true);
    this->_qMqttClient->setKeepAlive(1000);

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // 接続時
    connect(this->_qMqttClient, &QMqttClient::connected, this, [this]() {
        Logger::info(metaObject()->className(), __FUNCTION__, "MQTT brokerに接続しました。");

        // サブスクライブ
        auto topicNameList = Topics::getResultTopicNameList();
        for (const auto &topicName : topicNameList) {
            QMqttSubscription *subscription = this->_qMqttClient->subscribe(topicName);
            if (!subscription) {
                Logger::error(metaObject()->className(), __FUNCTION__, "トピックのサブスクライブに失敗: " + topicName);
            }
        }

        Logger::info(metaObject()->className(), __FUNCTION__, "トピックのサブスクライブ完了");
    });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // メッセージ受信時
    connect(this->_qMqttClient, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
        Logger::info(metaObject()->className(), __FUNCTION__, "Mqtt Message Receive topic: " + topic.name() + ", message: " + message);
        emit this->messageReceived(topic.name(), message);
    });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // 切断時
    connect(this->_qMqttClient, &QMqttClient::disconnected, this, [this]() {
        Logger::info(metaObject()->className(), __FUNCTION__, "MQTT brokerから切断されました。");

        // 切断時に直後に再接続を行うより、間を置く
        QTimer::singleShot(1000, this, [this]() {
            Logger::info(metaObject()->className(), __FUNCTION__, "再接続を試みます。");
            // 再接続する
            this->_qMqttClient->connectToHost();
        });
    });

    // 送信時にクラッシュする事があったため、publishする処理はスレッドで行う
    this->_mqttSenderThread = QtConcurrent::run([this]() {
        while (this->_senderRunning) {
            if (this->_mqttSenders.isEmpty()) {
                // 送信するメッセージがある場合は、スレッドを待機させる
                QThread::msleep(1);
                continue;
            }
            this->_senderMutex.lock();
            auto sender = this->_mqttSenders.takeFirst();
            this->_senderMutex.unlock();
            // FIXME: サブスレッドからネットワーク操作は出来ないというワーニングが出て送信処理は行われない
            // this->_qMqttClient->publish(sender.topic, sender.message);
        }
    });
}

MqttController::~MqttController()
{
    this->_senderRunning = false;
    this->_mqttSenderThread.waitForFinished();
}

/**
 * @brief MQTTクライアントの初期化を行います。接続まで行われます。
 *
 * @param hostName
 * @param port
 * @param username
 * @param password
 */
void MqttController::init(const QString &hostName, quint16 port, const QString &username, const QString &password)
{
    this->_qMqttClient->setHostname(hostName);
    this->_qMqttClient->setPort(port);
    this->_qMqttClient->setProtocolVersion(QMqttClient::MQTT_5_0);
    this->_qMqttClient->setUsername(username);
    this->_qMqttClient->setPassword(password);
    this->_qMqttClient->connectToHost();
}

/**
 * @brief メッセージを送信します。
 *
 * @param topic トピック名
 * @param message 本文
 */
void MqttController::sendMessage(const QString &topic, const QByteArray &message)
{
    if (this->_qMqttClient->state() == QMqttClient::Connected) {

        this->_senderMutex.lock();
        this->_mqttSenders.append({ topic, message });
        this->_senderMutex.unlock();

        // FIXME:
        this->_qMqttClient->publish(topic, message);
    } else {
        Logger::error(metaObject()->className(), __FUNCTION__, "MQTT clientに接続されていません。送信は行われません。: topic: " + topic + ", message: " + message);
    }
}
