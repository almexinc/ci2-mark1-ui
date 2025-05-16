#ifndef LOGCONTROLLER_H
#define LOGCONTROLLER_H

#include <QMutex>
#include <QObject>
#include <QQmlEngine>
#include <QtCore>

class LogController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    LogController(const LogController &)            = delete;
    LogController &operator=(const LogController &) = delete;
    LogController(LogController &&)                 = delete;
    LogController &operator=(LogController &&)      = delete;

    static LogController *getInstance();

    void init(const QString &logOutputFilePath);

    void info(const QString &text);

    void addLog(const QString &level, const QString &text, const QString &logOutputFilePath);

private:
    class LogWriter : public QThread
    {
    public:
        struct LogData {
            QString level;
            QString datetime;
            QString fileName;
            QString text;

            QString createLogText() const;
        };

        void addLog(const QString &level, const QString &text, const QString &logOutputFilePath);

    protected:
        void run();

    private:
        void           writeLog();
        QList<LogData> _queue;
        QMutex         _mutex;
    };

    LogController();
    void    deleteLogFile(int deleteDays);
    QString getLogFilePath();

    LogWriter _logWriter;
    QDir      _logDir;
};

#endif // LOGCONTROLLER_H
