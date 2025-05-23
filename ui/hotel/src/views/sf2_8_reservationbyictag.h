/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_8_RESERVATIONBYICTAG_H
#define SF2_8_RESERVATIONBYICTAG_H

#include <QObject>
#include <QQmlEngine>

class SF2_8_ReservationByICTag : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_8_ReservationByICTag(QObject *parent = nullptr);

    /**
     * @brief 画面が生成されてから行われるC++側の初期化処理
     */
    Q_INVOKABLE void init();

signals:
    /**
     * @brief 画面が生成されてから操作可能になった事を通知するシグナル
     */
    void initialized();
};

#endif // SF2_8_RESERVATIONBYICTAG_H
