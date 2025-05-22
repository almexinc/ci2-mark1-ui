#include "sharedcontroller.h"

#include "common/src/controller/uisettingcontroller.h"
#include "common/src/utils/logger.h"

SharedController::SharedController()
    : QObject { nullptr }
{
    this->_mqttController = new MqttController(this);

    {
        auto [hostName, port, username, password] = UiSettingController::getInstance()->getMqttSetting();
        this->_mqttController->init(hostName, port, username, password);
    }

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