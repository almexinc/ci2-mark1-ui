/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef RESOURCECONTROLLER_H
#define RESOURCECONTROLLER_H

#include <QObject>

#include <QDir>

class ResourceController : public QObject
{
    Q_OBJECT
public:
    ResourceController(const ResourceController &)            = delete;
    ResourceController &operator=(const ResourceController &) = delete;
    ResourceController(ResourceController &&)                 = delete;
    ResourceController &operator=(ResourceController &&)      = delete;

    static ResourceController *getInstance();

    QString getLogDirPath() const;
    QString getSettingDirPath() const;

signals:

private:
    ResourceController();

    QDir _rootDir;
};

#endif // RESOURCECONTROLLER_H
