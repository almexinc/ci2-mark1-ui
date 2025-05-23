/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "sharedcontroller.h"

#include "common/src/controller/resourcecontroller.h"
#include "common/src/controller/screentransitioncontroller.h"
#include "common/src/controller/uisettingcontroller.h"
#include "common/src/utils/logger.h"

SharedController::SharedController()
    : QObject { nullptr }
{
    this->_mqttController = new MqttController(this);

    {
        // MQTTの環境構築
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

        // 有効なダミーデータがあれば、ダミーのレスポンスを送信する
        this->_dummyResponse.sendDummyResponse(topic);
    });

    {
        // ダミーレスポンスの環境構築
        this->_dummyResponse.init(ResourceController::getInstance()->getDummyResponseDirPath(), UiSettingController::getInstance()->getDummyResponse());
        // ダミーデータの解析後にMQTTへの送信シグナルを発行する
        connect(&this->_dummyResponse, &DummyResponse::dummyPublish, this, [this](const QString &topicName, const QByteArray &message) {
            // ダミーのレスポンスをMQTTに送信する（通常は自分でサブスクライブしているのでそのまま自分で受け取ることになる）
            emit this->_mqttController->sendMessage(topicName, message);
        });
    }
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

/**
 * @brief 画面遷移を行うメソッド。
 * 設定ファイル hotel_screen_transition.json に記載されているqmlNameを元に遷移先の画面を決定する。
 * @param screenId 現在の画面名
 * @param condition 遷移条件
 */
void SharedController::nextScreen(const QString &screenId, int condition)
{
    auto name = ScreenTransitionController::getInstance()->getNextScreen(screenId, condition);
    emit this->qmlFilePushScreen(name);
}

/**
 * @brief QML側で言語切り替えボタンが押下された際に呼ばれるメソッド
 * @param languageCode 切り替わった言語コード
 */
void SharedController::changeLanguageCodeForQml(const QString &languageCode)
{
    Logger::info("SharedController", __FUNCTION__, "言語切り替え: " + languageCode);
    emit this->changeLanguageCode(languageCode);
}