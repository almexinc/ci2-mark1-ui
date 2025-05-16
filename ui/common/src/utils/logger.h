#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>

class Logger : public QObject
{
    Q_OBJECT
public:
    explicit Logger(QObject *parent = nullptr);

    static void info(const QString &sourceName, const QString &method, const QString &text);

signals:
};

#endif // LOGGER_H
