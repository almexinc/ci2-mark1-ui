﻿/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SHAREDCONTROLLER_H
#define SHAREDCONTROLLER_H

#include <QObject>
#include <QQmlEngine>

#include "common/src/utils/dummyresponse.h"
#include "mqttcontroller.h"

class SharedController : public QObject
{
    Q_OBJECT

public:
    SharedController(const SharedController &)            = delete;
    SharedController &operator=(const SharedController &) = delete;
    SharedController(SharedController &&)                 = delete;
    SharedController &operator=(SharedController &&)      = delete;

    static SharedController *getInstance();

    /**
     * @brief QML側でログを出力するためのメソッド
     *
     * @param text
     */
    Q_INVOKABLE void qmlLogInfo(const QString &text);

    /**
     * @brief QML側でエラーログを出力するためのメソッド
     *
     * @param text
     */
    Q_INVOKABLE void qmlLogError(const QString &text);

    /**
     * @brief 画面遷移を行うメソッド。
     * 設定ファイル hotel_screen_transition.json に記載されているqmlNameを元に遷移先の画面を決定する。
     * @param screenId 現在の画面名
     * @param condition 遷移条件
     */
    void nextScreen(const QString &screenId, int condition);

    /**
     * @brief 言語切り替えボタンが押下された際に呼ばれるメソッド
     * @param languageCode 切り替わった言語コード
     */
    Q_INVOKABLE void changeLanguageCodeForQml(const QString &languageCode);

    /**
     * @brief Get the Language Code object
     *
     * @return QString
     */
    QString getLanguageCode() const { return this->_languageCode; }

signals:
    /**
     * @brief MQTTメッセージ受信時に通知されるシグナル
     *
     * @param topic トピック名
     * @param message メッセージ本文
     */
    void mqttMessageReceived(const QString &topic, const QByteArray &message);

    /**
     * @brief MQTTメッセージ送信時に使用するシグナル
     *
     * @param topic トピック名
     * @param message メッセージ本文
     */
    void mqttMessageSend(const QString &topic, const QByteArray &message);

    /**
     * @brief 指定の .qml ファイルを読み込み、画面遷移する
     * NOTE: 画面遷移を呼ぶと、onRemovedまで関数コールで呼ばれる点に注意（emitが終わったらonRemovedも呼ばれてしまう）
     *
     * @param qmlFileName .qml QMLファイル名。例） qrc:/views/pages/Test.qml なら Test だけ指定する
     */
    void qmlFilePushScreen(const QString &qmlFileName);

    /**
     * @brief 言語切り替え時に通知されるシグナル
     * 主に動的にメッセージを変更する必要がある画面でconnectして使用する
     * @param languageCode 切り替わった言語コード
     */
    void changeLanguageCode(const QString &languageCode);

private:
    SharedController();
    MqttController *_mqttController;
    DummyResponse   _dummyResponse; // 送信処理に合わせて DummyResponse を使用する
    QString         _languageCode;  // 現在の言語コード。言語コードは ui/hotel/view/Constans.qml に定義されているlanguageButtonListに順ずる。
};

#endif // SHAREDCONTROLLER_H
