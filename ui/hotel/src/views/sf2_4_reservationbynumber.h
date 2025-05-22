#ifndef SF2_4_RESERVATIONBYNUMBER_H
#define SF2_4_RESERVATIONBYNUMBER_H

#include <QObject>
#include <QQmlEngine>

class SF2_4_ReservationByNumber : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_4_ReservationByNumber(QObject *parent = nullptr);

signals:
};

#endif // SF2_4_RESERVATIONBYNUMBER_H
