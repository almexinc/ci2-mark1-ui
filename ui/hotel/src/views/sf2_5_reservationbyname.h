/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_5_RESERVATIONBYNAME_H
#define SF2_5_RESERVATIONBYNAME_H

#include <QObject>
#include <QQmlEngine>

class SF2_5_ReservationByName : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_5_ReservationByName(QObject *parent = nullptr);

signals:
};

#endif // SF2_5_RESERVATIONBYNAME_H
