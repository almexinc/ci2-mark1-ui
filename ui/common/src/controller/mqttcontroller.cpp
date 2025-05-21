/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "mqttcontroller.h"

#include "common/src/topics/topics.h"
#include "common/src/utils/logger.h"

MqttController::MqttController(QObject *parent)
    : QObject(parent)
{
#ifdef GTO_DEBUG
    this->_qMqttClient = new QMqttClient(this);
    this->_qMqttClient->setAutoKeepAlive(true);
    this->_qMqttClient->setKeepAlive(1000);

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // 接続時
    connect(&this->_qMqttClient, &QMqttClient::connected, this, []() {
        qInfo() << "Connected to MQTT broker";

        // TODO: サブスクライブする
        // auto topicNameList = Topics::getResultTopicNameList();
    });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // メッセージ受信時
    connect(&this->_qMqttClient, &QMqttClient::messageReceived, this, &MqttController::messageReceived);

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // メッセージ変更時
    connect(&this->_qMqttClient, &QMqttClient::willMessageChanged, this, []() { qInfo() << "Will message changed"; });

    // Mqttクライアントから通知されるsignalに対するslotのconnect設定
    // 切断時
    connect(&this->_qMqttClient, &QMqttClient::disconnected, this, []() { qInfo() << "Disconnected from MQTT broker"; });
#endif // GTO_DEBUG

    // TODO: 仮
    // this->_qMqttClient->setHostname("localhost");
    // this->_qMqttClient->setPort(1883);
    // this->_qMqttClient->setProtocolVersion(QMqttClient::MQTT_5_0);
    // this->_qMqttClient->connectToHost();
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
    Q_UNUSED(hostName);
    Q_UNUSED(port);
    Q_UNUSED(username);
    Q_UNUSED(password);
#ifdef GTO_DEBUG
    this->_qMqttClient->setHostname(hostName);
    this->_qMqttClient->setPort(port);
    this->_qMqttClient->setProtocolVersion(QMqttClient::MQTT_5_0);
    this->_qMqttClient->setUsername(username);
    this->_qMqttClient->setPassword(password);
    this->_qMqttClient->connectToHost();
#endif // GTO_DEBUG
}

/**
 * @brief メッセージを送信します。
 *
 * @param topic トピック名
 * @param message 本文
 */
void MqttController::sendMessage(const QString &topic, const QString &message)
{
    Q_UNUSED(topic);
    Q_UNUSED(message);
#ifdef GTO_DEBUG
    // TODO: 送信する処理はスレッドになる模様

    if (this->_qMqttClient->state() == QMqttClient::Connected) {
        this->_qMqttClient->publish(topic, message.toUtf8());
    } else {
        Logger::error(metaObject()->className(), __FUNCTION__, "MQTT clientに接続されていません。送信は行われません。");
        // TODO: 待機状態にする？
    }
#endif // GTO_DEBUG
}
