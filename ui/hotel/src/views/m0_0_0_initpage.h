#ifndef M______INITPAGE_H
#define M______INITPAGE_H

#include <QObject>
#include <QQmlEngine>

class M0_0_0_InitPage : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit M0_0_0_InitPage(QObject *parent = nullptr);
    ~M0_0_0_InitPage();

    Q_INVOKABLE void nextScreen();

signals:
};

#endif // M______INITPAGE_H
