/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_6_RESERVATIONBYQR_H
#define SF2_6_RESERVATIONBYQR_H

#include <QObject>
#include <QQmlEngine>

#include "common/src/topics/testtopic.h"

class SF2_6_ReservationByQR : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_6_ReservationByQR(QObject *parent = nullptr);

    /**
     * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
     */
    Q_INVOKABLE void onRemoved();

    /**
     * @brief 画面が生成されてから行われるC++側の初期化処理
     */
    Q_INVOKABLE void init();

signals:
    /**
     * @brief 画面が生成されてから操作可能になった事を通知するシグナル
     */
    void initialized();

private:
    /**
     * @brief MQTTメッセージ受信処理
     *
     * @param topic トピック名
     * @param message メッセージ本文
     */
    void mqttMessageReceived(const QString &topic, const QByteArray &message);

    /**
     * @brief TODO: QRコード読み取り結果の送信結果を受信する
     */
    void resultTestTopic();

    /**
     * @brief TODO: QRコード読み取り結果の通知を受信する
     */
    void noticeTestTopic();

    TestTopic _testTopic; // TODO: 動作確認用の仮トピック
};

#endif // SF2_6_RESERVATIONBYQR_H
