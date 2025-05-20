#ifndef SHAREDCONTROLLER_H
#define SHAREDCONTROLLER_H

#include <QObject>
#include <QQmlEngine>

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
     * @brief 指定の .qml ファイルを読み込むことを通知
     * @param qmlFileName .qml QMLファイル名。例） qrc:/qml/views/Test.qml なら Test だけ指定する
     */
    void qmlFilePushScreen(const QString &qmlFileName);

private:
    SharedController();
    MqttController *_mqttController;
};

#endif // SHAREDCONTROLLER_H
