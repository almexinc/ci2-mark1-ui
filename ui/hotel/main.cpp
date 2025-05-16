#include <QDebug>
#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QUrl>

#include "common/src/controller/logcontroller.h"
#include "common/src/utils/logger.h"

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
    QGuiApplication app(argc, argv);

    // コントローラーのセットアップ
    LogController::getInstance()->init(QCoreApplication::applicationDirPath() + "/log"); // TODO: パス管理先は変える

    QTranslator translator;
    QString     locale = "ja";
    if (translator.load(":/i18n/hotel_" + locale + ".qm")) {
        QCoreApplication::installTranslator(&translator);
    }

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() {
            // 最初のQMLの読み込み失敗
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));

    // アプリケーションがqrc:で取得出来る全リソースの出力
    printResourceTree(":/");

    Logger::info("main", __FUNCTION__, "アプリケーションが起動しました。");

    return app.exec();
}
