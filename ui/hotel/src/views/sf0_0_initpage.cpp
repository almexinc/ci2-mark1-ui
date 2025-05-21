#include "sf0_0_initpage.h"

#include <QTimer>

#include "common/src/controller/sharedcontroller.h"
#include "common/src/utils/logger.h"

SF0_0_InitPage::SF0_0_InitPage(QObject *parent)
    : QObject { parent }
{
    Logger::info(metaObject()->className(), __FUNCTION__, "コンストラクタコール");

    // MQTTメッセージ受信シグナルを接続
    connect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF0_0_InitPage::mqttMessageReceived);

    // TODO: 適切な画面処理が必要になるまで、仮で遷移する
    QTimer::singleShot(100, this, [this]() {
        // NOTE: 画面遷移を呼ぶと、onRemovedまで関数コールで呼ばれる点に注意（emitが終わったらonRemovedも呼ばれてしまう）
        emit SharedController::getInstance() -> qmlFilePushScreen("SF2-1_Idle");
    });
}

/**
 * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
 */
void SF0_0_InitPage::onRemoved()
{
    Logger::info(metaObject()->className(), __FUNCTION__, "onRemovedコール");
    // 画面遷移時にMQTTの受信が次画面と交差しないようにシグナルを切断する
    disconnect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF0_0_InitPage::mqttMessageReceived);
}

/**
 * @brief MQTTメッセージ受信処理
 *
 * @param topic トピック名
 * @param message メッセージ本文
 */
void SF0_0_InitPage::mqttMessageReceived(const QString &topic, const QByteArray &message)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "topic: " + topic + ", message: " + message);
}