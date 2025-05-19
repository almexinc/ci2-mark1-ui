/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "logger.h"

#include "common/src/controller/logcontroller.h"

Logger::Logger(QObject *parent)
    : QObject { parent }
{
}

void Logger::info(const QString &sourceName, const QString &method, const QString &text)
{
    QString logText = QString("%1::%2: %3").arg(sourceName, method, text);
    LogController::getInstance()->info(logText);
}

void Logger::error(const QString &sourceName, const QString &method, const QString &text)
{
    QString logText = QString("%1::%2: %3").arg(sourceName, method, text);
    LogController::getInstance()->error(logText);
}