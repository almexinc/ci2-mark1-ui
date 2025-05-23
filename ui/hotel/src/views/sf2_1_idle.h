﻿/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_1_IDLE_H
#define SF2_1_IDLE_H

#include <QObject>
#include <QQmlEngine>

class SF2_1_Idle : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_1_Idle(QObject *parent = nullptr);

    /**
     * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
     */
    Q_INVOKABLE void onRemoved();

    /**
     * @brief 画面が生成されてから行われるC++側の初期化処理
     */
    Q_INVOKABLE void init();

    /**
     * @brief メニューボタン押下処理
     *
     * @param condition メニューボタン押下条件
     */
    Q_INVOKABLE void menuButtonClicked(int condition);

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
};

#endif // SF2_1_IDLE_H
