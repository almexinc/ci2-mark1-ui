#include "m0_0_0_initpage.h"

#include "common/src/controller/sharedcontroller.h"
#include "common/src/utils/logger.h"

M0_0_0_InitPage::M0_0_0_InitPage(QObject *parent)
    : QObject { parent }
{
    Logger::info(metaObject()->className(), __FUNCTION__, "コンストラクタコール");

    connect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &M0_0_0_InitPage::mqttMessageReceived);
}

M0_0_0_InitPage::~M0_0_0_InitPage()
{
    qInfo() << "M0_0_0_InitPage::~M0_0_0_InitPage: ";
}

/**
 * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる
 *
 */
void M0_0_0_InitPage::onRemoved()
{
    Logger::info(metaObject()->className(), __FUNCTION__, "onRemoved");

    // 画面遷移時にMQTTの受信が次画面と交差しないようにシグナルを切断する
    disconnect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &M0_0_0_InitPage::mqttMessageReceived);
}

/**
 * @brief 次の画面に遷移する
 */
void M0_0_0_InitPage::nextScreen()
{
    emit SharedController::getInstance() -> qmlFilePushScreen("te0_0_1_TestIdle");
}

/**
 * @brief MQTTメッセージ受信処理
 *
 * @param topic トピック名
 * @param message メッセージ本文
 */
void M0_0_0_InitPage::mqttMessageReceived(const QString &topic, const QByteArray &message)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "topic: " + topic + ", message: " + message);

    // TODO: 処理したいトピック名を多数並べて、一致したトピックのメッセージを処理する
}
