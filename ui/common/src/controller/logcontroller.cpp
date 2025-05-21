/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "logcontroller.h"

LogController::LogController()
    : QObject { nullptr }
{
    _logWriter.start();
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

/**
 * @brief 実行直後と、24h間ごとにログファイルを削除する。
 *
 * @param deleteDays 保持日数 1日以下は許容しない。最低値の2日として扱う
 */
void LogController::startIntervalDeleteLog(int deleteDays)
{
    if (deleteDays <= 1) { // 1日未満はデフォルト値に設定する
        deleteDays = 2;
    }

    // 関数実行時にログファイルを削除する
    this->deleteLogFile(deleteDays);

    // インターバル処理開始
    static bool oneRunning = false;
    if (!oneRunning) {
        oneRunning = true;

        // QTimerで起動してから24時間ごとにログファイルを削除する
        QTimer *timer = new QTimer(this);
        connect(timer, &QTimer::timeout, this, [this, deleteDays]() {
            this->deleteLogFile(deleteDays);
        });
        timer->setSingleShot(false);
        timer->start(24 * 60 * 60 * 1000); // 24時間
    }
}

/**
 * @brief アプリ終了時に呼び出す
 */
void LogController::stopLogWriter()
{
    this->_logWriter._writerRunning = false;
    this->_logWriter.quit();
    this->_logWriter.wait();
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
        // qInfo() << info.absoluteFilePath() << info.birthTime();
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
    log._level    = level;
    log._text     = text;
    log._datetime = QDateTime::currentDateTime().toString("yyyy/MM/dd HH:mm:ss.zzz");
    log._fileName = logOutputFilePath;

    if (!log._text.isEmpty()) {
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
    do {
        this->writeLog();
    } while (this->_writerRunning);
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

    QFile file(logData._fileName);
    if (file.open(QIODevice::WriteOnly | QIODevice::Append)) {
        QTextStream stream(&file);
        stream.setEncoding(QStringConverter::Utf8);

        stream << logData.createLogText();
        stream << "\n";

        file.flush();
        file.close();
    } else {
        qInfo() << "Coundn't access to file:" << logData._fileName;
    }
}

QString LogController::LogWriter::LogData::createLogText() const
{
    // 一番長いFATALの長さに合わせる
    QString toLevel = _level.isEmpty() ? "     " : _level;
    auto    toText  = _text;
    toText.replace("\n", "");
    return QString("%1 %2 %3").arg(_datetime, toLevel, toText);
}
