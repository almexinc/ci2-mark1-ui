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

signals:
};

#endif // SF2_8_RESERVATIONBYICTAG_H
