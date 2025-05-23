/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_7_RESERVATIONBYPRECARD_H
#define SF2_7_RESERVATIONBYPRECARD_H

#include <QObject>
#include <QQmlEngine>

class SF2_7_ReservationByPreCard : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_7_ReservationByPreCard(QObject *parent = nullptr);

signals:
};

#endif // SF2_7_RESERVATIONBYPRECARD_H
