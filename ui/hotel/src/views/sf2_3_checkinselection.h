#ifndef SF2_3_CHECKINSELECTION_H
#define SF2_3_CHECKINSELECTION_H

#include <QObject>
#include <QQmlEngine>

class SF2_3_CheckInSelection : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_3_CheckInSelection(QObject *parent = nullptr);

    /**
     * @brief 画面破棄時に次の画面のコンストラクタが呼ばれるより先に呼ばれる(QMLのStateのonRemovedで呼ぶよう実装する)
     */
    Q_INVOKABLE void onRemoved();

    /**
     * @brief メニューボタン押下処理
     *
     * @param condition メニューボタン押下条件
     */
    Q_INVOKABLE void menuButtonClicked(int condition);

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

#endif // SF2_3_CHECKINSELECTION_H
