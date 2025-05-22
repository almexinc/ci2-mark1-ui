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

signals:
};

#endif // SF2_3_CHECKINSELECTION_H
