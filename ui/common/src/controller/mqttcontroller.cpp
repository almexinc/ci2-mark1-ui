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
    connect(this->_qMqttClient, &QMqttClient::connected, this, []() {
        qInfo() << "Connected to MQTT broker";

        // TODO: サブスクライブする
        // auto topicNameList = Topics::getResultTopicNameList();
    });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // メッセージ受信時
    connect(this->_qMqttClient, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
        qInfo() << "Message received on topic:" << topic.name() << ", message:" << message;
    });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // 切断時
    connect(this->_qMqttClient, &QMqttClient::disconnected, this, [this]() {
        qInfo() << "Disconnected from MQTT broker";

        // 再接続する
        this->_qMqttClient->connectToHost();
    });

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
            this->_qMqttClient->publish(sender.topic, sender.message);
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
    Q_UNUSED(topic);
    Q_UNUSED(message);

    // TODO: 送信する処理はスレッドになる模様

    if (this->_qMqttClient->state() == QMqttClient::Connected) {

        this->_senderMutex.lock();
        this->_mqttSenders.append({ topic, message });
        this->_senderMutex.unlock();
    } else {
        Logger::error(metaObject()->className(), __FUNCTION__, "MQTT clientに接続されていません。送信は行われません。");
        // TODO: 待機状態にする？
    }
}
