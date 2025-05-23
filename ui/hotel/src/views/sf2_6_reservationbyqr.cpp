/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "sf2_6_reservationbyqr.h"

#include "common/src/controller/sharedcontroller.h"
#include "common/src/utils/logger.h"
#include "common/src/utils/screenid.h"

SF2_6_ReservationByQR::SF2_6_ReservationByQR(QObject *parent)
    : QObject { parent }
{
    Logger::info(metaObject()->className(), __FUNCTION__, "コンストラクタコール");

    // MQTTメッセージ受信シグナルを接続
    connect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF2_6_ReservationByQR::mqttMessageReceived);

    // TODO: 画面遷移と同時にQRの読み込みを開始するイメージ
    auto [topic, message] = _testTopic.requestStartRead();
    SharedController::getInstance()->mqttMessageSend(topic, message);
}

/**
 * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
 */
void SF2_6_ReservationByQR::onRemoved()
{
    // 画面遷移時にMQTTの受信が次画面と交差しないようにシグナルを切断する
    disconnect(SharedController::getInstance(), &SharedController::mqttMessageReceived, this, &SF2_6_ReservationByQR::mqttMessageReceived);
}

/**
 * @brief MQTTメッセージ受信処理
 *
 * @param topic トピック名
 * @param message メッセージ本文
 */
void SF2_6_ReservationByQR::mqttMessageReceived(const QString &topic, const QByteArray &message)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "topic: " + topic + ", message: " + message);

    // TODO: QR関係のトピック処理イメージ
    auto checkTopicType = _testTopic.checkTopic(topic, message);
    if (checkTopicType == CheckTopicType::E_RESULT) {
        this->resultTestTopic();
        return;

    } else if (checkTopicType == CheckTopicType::E_NOTICE) {
        this->noticeTestTopic();
        return;
    }
}

/**
 * @brief TODO: QRコード読み取り結果の送信結果を受信する
 */
void SF2_6_ReservationByQR::resultTestTopic()
{
    auto result = _testTopic.getResultData();
    Logger::info(metaObject()->className(), __FUNCTION__, "readId: " + result._readId);
}

/**
 * @brief TODO: QRコード読み取り結果の通知を受信する
 */
void SF2_6_ReservationByQR::noticeTestTopic()
{
    auto notice = _testTopic.getNoticeData();
    Logger::info(metaObject()->className(), __FUNCTION__, "readId: " + notice._readId);

    // メニュー画面遷移
    SharedController::getInstance()->nextScreen(ID_SF2_6_RESERVATION_BY_QR, 0);
}