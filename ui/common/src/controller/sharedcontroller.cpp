#include "sharedcontroller.h"

#include "common/src/utils/logger.h"

SharedController::SharedController()
    : QObject { nullptr }
{
    this->_mqttController = new MqttController(this);
    this->_mqttController->init("localhost", 1883, "user", "password"); // TODO: 設定ファイルから読み込ませる

    // MQTTメッセージを受け取り、再びシグナルを発行する
    connect(this->_mqttController, &MqttController::messageReceived, this, [this](const QString &topic, const QByteArray &message) {
        emit this->mqttMessageReceived(topic, message);
    });

    // MQTTメッセージを送信する
    connect(this, &SharedController::mqttMessageSend, this->_mqttController, [this](const QString &topic, const QByteArray &message) {
        this->_mqttController->sendMessage(topic, message);

        // TODO: ダミーデータの送信
    });
}

SharedController *SharedController::getInstance()
{
    static SharedController instance;
    return &instance;
}

/**
 * @brief QML側でログを出力するためのメソッド
 *
 * @param text
 */
void SharedController::qmlLogInfo(const QString &text)
{
    Logger::info("qml", "", text);
}

/**
 * @brief QML側でエラーログを出力するためのメソッド
 *
 * @param text
 */
void SharedController::qmlLogError(const QString &text)
{
    Logger::info("qml", "", text);
}