/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef MQTTCONTROLLER_H
#define MQTTCONTROLLER_H

#include <QMqttClient>
#include <QObject>

class MqttController : public QObject
{
    Q_OBJECT
public:
    explicit MqttController(QObject *parent = nullptr);

    /**
     * @brief MQTTクライアントの初期化を行います。接続まで行われます。
     *
     * @param hostName
     * @param port
     * @param username
     * @param password
     */
    void init(const QString &hostName, quint16 port, const QString &username, const QString &password);

    /**
     * @brief メッセージを送信します。
     *
     * @param topic トピック名
     * @param message 本文
     */
    void sendMessage(const QString &topic, const QString &message);

signals:
    void messageReceived(const QString &topic, const QByteArray &message);
    void connected();
    void disconnected();

private:
    QMqttClient *_qMqttClient;
};

#endif // MQTTCONTROLLER_H
