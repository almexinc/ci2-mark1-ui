/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_11_RESERVATIONBYPHONE_H
#define SF2_11_RESERVATIONBYPHONE_H

#include <QObject>
#include <QQmlEngine>

class SF2_11_ReservationByPhone : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_11_ReservationByPhone(QObject *parent = nullptr);

signals:
};

#endif // SF2_11_RESERVATIONBYPHONE_H
