/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef TE____1_TESTIDLE_H
#define TE____1_TESTIDLE_H

#include <QObject>
#include <QQmlEngine>

#include "common/src/topics/testtopic.h"

class TE0_0_1_TestIdle : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit TE0_0_1_TestIdle(QObject *parent = nullptr);
    ~TE0_0_1_TestIdle();

    /**
     * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる
     */
    Q_INVOKABLE void onRemoved();

signals:

private:
    /**
     * @brief MQTTメッセージ受信処理
     *
     * @param topic トピック名
     * @param message メッセージ本文
     */
    void mqttMessageReceived(const QString &topic, const QByteArray &message);

    TestTopic _testTopic; // TestTopic を送受信する
};

#endif // TE____1_TESTIDLE_H
