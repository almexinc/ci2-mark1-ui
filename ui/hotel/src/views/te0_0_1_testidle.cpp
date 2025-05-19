#include "te0_0_1_testidle.h"

#include "common/src/controller/sharedcontroller.h"
#include "common/src/utils/logger.h"

TE0_0_1_TestIdle::TE0_0_1_TestIdle(QObject *parent)
    : QObject { parent }
{
    Logger::info(metaObject()->className(), __FUNCTION__, "コンストラクタコール");
    connect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &TE0_0_1_TestIdle::mqttMessageReceived);
}

TE0_0_1_TestIdle::~TE0_0_1_TestIdle()
{
    qInfo() << "TE0_0_1_TestIdle::~TE0_0_1_TestIdle: ";
}

/**
 * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる
 *
 */
void TE0_0_1_TestIdle::onRemoved()
{
    Logger::info(metaObject()->className(), __FUNCTION__, "onRemoved");

    // 画面遷移時にMQTTの受信が次画面と交差しないようにシグナルを切断する
    disconnect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &TE0_0_1_TestIdle::mqttMessageReceived);
}

/**
 * @brief MQTTメッセージ受信処理
 *
 * @param topic トピック名
 * @param message メッセージ本文
 */
void TE0_0_1_TestIdle::mqttMessageReceived(const QString &topic, const QByteArray &message)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "topic: " + topic + ", message: " + message);

    // TODO: 処理したいトピック名を多数並べて、一致したトピックのメッセージを処理する
}