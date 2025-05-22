/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

#include "resourcecontroller.h"

#include <QtCore>

ResourceController::ResourceController()
{
    _rootDir.setPath(QCoreApplication::applicationDirPath());
#ifdef QT_DEBUG
    _rootDir.setPath(ROOT_PATH); // CMakefileで定義したパス
#endif

    auto almexPath = QString(qgetenv("ALMEXPATH"));
    if (!almexPath.isEmpty()) {
        _rootDir.setPath(almexPath);
    }

    qInfo() << "ResourceController::ResourceController: " << _rootDir.absolutePath();
    qInfo() << "getLogDirPath: " << this->getLogDirPath();
}

ResourceController *ResourceController::getInstance()
{
    static ResourceController instance;
    return &instance;
}

/**
 * @brief ログ出力先のディレクトリパスを取得する
 *
 * @return QString ログ出力フルパス
 */
QString ResourceController::getLogDirPath() const
{
    return this->_rootDir.absolutePath() + "/etc/log";
}

QString ResourceController::getSettingDirPath() const
{
    return this->_rootDir.absolutePath() + "/etc/yaml";
}

QString ResourceController::getDummyResponseDirPath() const
{
    return this->_rootDir.absolutePath() + "/etc/dummy";
}