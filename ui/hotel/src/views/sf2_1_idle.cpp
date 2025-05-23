#include "sf2_1_idle.h"

#include "common/src/controller/sharedcontroller.h"
#include "common/src/utils/logger.h"
#include "common/src/utils/screenid.h"

SF2_1_Idle::SF2_1_Idle(QObject *parent)
    : QObject { parent }
{
    Logger::info(metaObject()->className(), __FUNCTION__, "コンストラクタコール");

    // MQTTメッセージ受信シグナルを接続
    connect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF2_1_Idle::mqttMessageReceived);
}

/**
 * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
 */
void SF2_1_Idle::onRemoved()
{
    // 画面遷移時にMQTTの受信が次画面と交差しないようにシグナルを切断する
    disconnect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF2_1_Idle::mqttMessageReceived);
}

/**
 * @brief メニューボタン押下処理
 *
 * @param condition メニューボタン押下条件
 */
void SF2_1_Idle::menuButtonClicked(int condition)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "メニューボタン押下: " + QString::number(condition));

    // メニュー画面遷移
    SharedController::getInstance()->nextScreen(ID_SF2_1_IDLE, condition);
}

/**
 * @brief MQTTメッセージ受信処理
 *
 * @param topic トピック名
 * @param message メッセージ本文
 */
void SF2_1_Idle::mqttMessageReceived(const QString &topic, const QByteArray &message)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "topic: " + topic + ", message: " + message);
}
