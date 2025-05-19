#include "sharedcontroller.h"

SharedController::SharedController()
    : QObject { nullptr }
{
    this->_mqttController = new MqttController(this);
    this->_mqttController->init("localhost", 1883, "user", "password"); // TODO: 設定ファイルから読み込ませる

    // MQTTメッセージを受け取り、再びシグナルを発行する
    connect(this->_mqttController, &MqttController::messageReceived, this, [this](const QString &topic, const QByteArray &message) {
        emit this->mqttMessageReceived(topic, message);
    });
}

SharedController *SharedController::getInstance()
{
    static SharedController instance;
    return &instance;
}
