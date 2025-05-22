#ifndef SF2_6_RESERVATIONBYQR_H
#define SF2_6_RESERVATIONBYQR_H

#include <QObject>
#include <QQmlEngine>

class SF2_6_ReservationByQR : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_6_ReservationByQR(QObject *parent = nullptr);

signals:
};

#endif // SF2_6_RESERVATIONBYQR_H
