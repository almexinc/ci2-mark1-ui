/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "logcontroller.h"

LogController::LogController()
{
    _logWriter.start();

    // QTimerで起動してから24時間ごとにログファイルを削除する
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, [this]() {
        // 365日以上前のログファイルを削除する
        this->deleteLogFile(365);
    });
    timer->start(24 * 60 * 60 * 1000); // 24時間
}

LogController *LogController::getInstance()
{
    static LogController instance;
    return &instance;
}

void LogController::init(const QString &logOutputFilePath)
{
    this->_logDir = QDir(logOutputFilePath);
    if (!this->_logDir.exists()) {
        this->_logDir.mkpath(".");
    }
}

void LogController::info(const QString &text)
{
    this->addLog("INFO ", text, this->getLogFilePath());
}

void LogController::error(const QString &text)
{
    this->addLog("ERROR", text, this->getLogFilePath());
}

void LogController::addLog(const QString &level, const QString &text, const QString &logOutputFilePath)
{
    this->_logWriter.addLog(level, text, logOutputFilePath);
}

QString LogController::getLogFilePath()
{
    return this->_logDir.absoluteFilePath(QCoreApplication::applicationName() + "_" + QDate::currentDate().toString("yyyyMMdd") + ".log");
}

void LogController::deleteLogFile(int deleteDays)
{
    QStringList nameFilters;
    nameFilters << (QCoreApplication::applicationName() + "_*.log");
    QList<QFileInfo> logList = QDir(_logDir).entryInfoList(nameFilters, QDir::Files | QDir::Writable);

    // 指定した日数より古いファイルを削除
    QDateTime deleteDate = QDateTime::currentDateTime().addDays(deleteDays * -1);
    for (QFileInfo &info : logList) {
        qInfo() << info.absoluteFilePath() << info.birthTime();
        if (info.birthTime() < deleteDate) {
            if (QFile::remove(info.filePath())) {
                // 通常はinitが終わってから呼ばれるのでログ出力はされる
                this->info(QString("ログファイルを削除しました: %1").arg(info.fileName()));
            }
        }
    }
}

/////////////////////////////////////////////
// LogWriter
/////////////////////////////////////////////

void LogController::LogWriter::addLog(const QString &level, const QString &text, const QString &logOutputFilePath)
{
    if (logOutputFilePath.isEmpty()) {
        return;
    }
    LogData log;
    log.level    = level;
    log.text     = text;
    log.datetime = QDateTime::currentDateTime().toString("yyyy/MM/dd HH:mm:ss.zzz");
    log.fileName = logOutputFilePath;

    if (!log.text.isEmpty()) {
        this->_mutex.lock();
        this->_queue.append(log);
        this->_mutex.unlock();
#ifdef QT_DEBUG
        qInfo() << log.createLogText();
#endif
    }
}

void LogController::LogWriter::run()
{
    while (true) {
        this->writeLog();
    }
}

void LogController::LogWriter::writeLog()
{
    if (_queue.isEmpty()) {
        msleep(10);
        return;
    }

    // ログの書き込みを開始
    this->_mutex.lock();
    auto logData = this->_queue.takeFirst();
    this->_mutex.unlock();

    QFile file(logData.fileName);
    if (file.open(QIODevice::WriteOnly | QIODevice::Append)) {
        QTextStream stream(&file);
        stream.setEncoding(QStringConverter::Utf8);

        stream << logData.createLogText();
        stream << "\n";

        file.flush();
        file.close();
    } else {
        qInfo() << "Coundn't access to file:" << logData.fileName;
    }
}

QString LogController::LogWriter::LogData::createLogText() const
{
    // 一番長いFATALの長さに合わせる
    QString toLevel = level.isEmpty() ? "     " : level;
    auto    toText  = text;
    toText.replace("\n", "");
    return QString("%1 %2 %3").arg(datetime, toLevel, toText);
}