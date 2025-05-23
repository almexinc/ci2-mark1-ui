/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef M______INITPAGE_H
#define M______INITPAGE_H

#include <QObject>
#include <QQmlEngine>

class M0_0_0_InitPage : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit M0_0_0_InitPage(QObject *parent = nullptr);
    ~M0_0_0_InitPage();

    /**
     * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる
     */
    Q_INVOKABLE void onRemoved();

    /**
     * @brief 次の画面に遷移する
     */
    Q_INVOKABLE void nextScreen();

signals:

private:
    /**
     * @brief MQTTメッセージ受信処理
     *
     * @param topic トピック名
     * @param message メッセージ本文
     */
    void mqttMessageReceived(const QString &topic, const QByteArray &message);
};

#endif // M______INITPAGE_H
