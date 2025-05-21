/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

#include <QDebug>
#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QUrl>
#include <QtQml>

#include "common/src/controller/logcontroller.h"
#include "common/src/controller/mqttcontroller.h"
#include "common/src/controller/resourcecontroller.h"
#include "common/src/controller/sharedcontroller.h"
#include "common/src/controller/uisettingcontroller.h"
#include "common/src/utils/logger.h"

/**
 * @brief 動作確認用。qrc: で取得できる全リソースを出力する
 *
 * @param path
 * @param depth
 */
void printResourceTree(const QString &path, int depth = 0)
{
    QDirIterator it(path, QDirIterator::NoIteratorFlags);
    while (it.hasNext()) {
        QString entry = it.next();
        qDebug().noquote().nospace() << QString(depth * 2, ' ') << entry;
        if (QFileInfo(entry).isDir()) {
            printResourceTree(entry, depth + 1);
        }
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication       app(argc, argv);
    QQmlApplicationEngine engine;

    // 各種コントローラーのセットアップ
    auto *resourceController = ResourceController::getInstance();
    LogController::getInstance()->init(resourceController->getLogDirPath());

    // 設定ファイルの読み込み
    auto *uiSettingController = UiSettingController::getInstance();
    uiSettingController->init(resourceController->getSettingDirPath() + "/ui_hotel_setting.yaml");

    // ログの削除&定期削除開始
    LogController::getInstance()->startIntervalDeleteLog(uiSettingController->getLogSaveDays());

    // MQTT含むコントローラーのセットアップ。QML側でも使うコードの登録
    auto sharedController = SharedController::getInstance();
    engine.rootContext()->setContextProperty("sharedController", sharedController);

    // 言語設定
    QTranslator translator;
    QString     locale = "ja";
    if (translator.load(":/i18n/hotel_" + locale + ".qm")) {
        QCoreApplication::installTranslator(&translator);
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() {
            // 最初のQMLの読み込み失敗
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(QUrl(QStringLiteral("qrc:/view/mainView.qml")));

    // アプリケーションがqrc:で取得出来る全リソースの出力
    // printResourceTree(":/");

    Logger::info("main", __FUNCTION__, "アプリケーションが起動しました。");

    // UIの表示
    auto ret = app.exec();

    LogController::getInstance()->stopLogWriter();

    return ret;
}
