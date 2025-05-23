#include "screentransitioncontroller.h"

#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

#include "common/src/utils/logger.h"

ScreenTransitionController::ScreenTransitionController()
    : QObject { nullptr }
{
}

ScreenTransitionController *ScreenTransitionController::getInstance()
{
    static ScreenTransitionController instance;
    return &instance;
}

void ScreenTransitionController::init(const QString &fileDirPath)
{
    Logger::info(metaObject()->className(), __FUNCTION__, "画面遷移設定ファイルの初期化: " + fileDirPath);

    // 画面遷移設定ファイルの読み込み
    QFile file(fileDirPath + "/ui_hotel_screen_transition.json");
    if (!file.open(QIODevice::ReadOnly)) {
        Logger::error(metaObject()->className(), __FUNCTION__, "画面遷移設定ファイルのオープンに失敗: " + fileDirPath);
        return;
    }

    // JSONデータを読み込む
    QByteArray jsonData = file.readAll();
    file.close();

    // JSONデータを解析する
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData);
    if (jsonDoc.isNull()) {
        Logger::error(metaObject()->className(), __FUNCTION__, "JSONデータの解析に失敗: " + fileDirPath);
        return;
    }

    // 設定ファイル構造
    // [
    //     {
    //         "fromScreen": "SF2-1_idle",
    //         "conditions": [
    //             {
    //                 "condition": 0,
    //                 "toScreen": "SF2-3_CheckInSelection"
    //             }
    //         ]
    //     }
    // ]

    if (!jsonDoc.isArray()) {
        Logger::error(metaObject()->className(), __FUNCTION__, "JSONデータが配列ではありません: " + fileDirPath);
        return;
    }

    for (QJsonArray transitionArray = jsonDoc.array(); const QJsonValue &transitionValue : qAsConst(transitionArray)) {
        if (!transitionValue.isObject()) {
            Logger::error(metaObject()->className(), __FUNCTION__, "遷移設定が正しくありません。スキップします。");
            continue;
        }

        QJsonObject transitionObj = transitionValue.toObject();
        QString     fromScreen    = transitionObj["fromScreen"].toString();

        if (fromScreen.isEmpty()) {
            Logger::error(metaObject()->className(), __FUNCTION__, "fromScreenが指定されていません。スキップします。");
            continue;
        }

        if (!transitionObj.contains("conditions") || !transitionObj["conditions"].isArray()) {
            Logger::error(metaObject()->className(), __FUNCTION__, "conditions定義が正しくありません: " + fromScreen);
            continue;
        }

        QJsonArray         conditionsArray = transitionObj["conditions"].toArray();
        QMap<int, QString> conditionMap;

        for (const QJsonValue &conditionValue : qAsConst(conditionsArray)) {
            if (!conditionValue.isObject()) {
                Logger::error(metaObject()->className(), __FUNCTION__, "条件設定が正しくありません。スキップします。");
                continue;
            }

            QJsonObject conditionObj = conditionValue.toObject();
            int         condition    = conditionObj["condition"].toInt(-1);
            QString     toScreen     = conditionObj["toScreen"].toString();

            if (condition == -1 || toScreen.isEmpty()) {
                Logger::error(metaObject()->className(), __FUNCTION__, "条件または遷移先画面が正しく指定されていません。スキップします。");
                continue;
            }

            conditionMap[condition] = toScreen;
        }

        this->_screenTransitionMap[fromScreen] = conditionMap;
    }
}

/**
 * @brief 渡された条件に合致する画面遷移先を取得する
 * @param currentScreen 現在の画面名
 * @param condition 条件
 * @return QString 画面名
 */
QString ScreenTransitionController::getNextScreen(const QString &currentScreen, int condition)
{
    if (this->_screenTransitionMap.contains(currentScreen)) {
        const auto &conditionMap = this->_screenTransitionMap[currentScreen];
        if (conditionMap.contains(condition)) {
            return conditionMap[condition];
        }
    }

    Logger::error(metaObject()->className(), __FUNCTION__, "画面遷移設定が見つかりません: " + currentScreen + ", condition: " + QString::number(condition));
    return QString();
}
