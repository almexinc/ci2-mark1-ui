/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SCREENTRANSITIONCONTROLLER_H
#define SCREENTRANSITIONCONTROLLER_H

#include <QMap>
#include <QObject>

class ScreenTransitionController : public QObject
{
    Q_OBJECT

public:
    ScreenTransitionController(const ScreenTransitionController &)            = delete;
    ScreenTransitionController &operator=(const ScreenTransitionController &) = delete;
    ScreenTransitionController(ScreenTransitionController &&)                 = delete;
    ScreenTransitionController &operator=(ScreenTransitionController &&)      = delete;

    static ScreenTransitionController *getInstance();

    void init(const QString &fileDirPath);

    /**
     * @brief 渡された条件に合致する画面遷移先を取得する
     * @param currentScreen 現在の画面名
     * @param condition 条件
     * @return QString 画面名
     */
    QString getNextScreen(const QString &currentScreen, int condition);

signals:

private:
    ScreenTransitionController();

    QMap<QString, QMap<int, QString>> _screenTransitionMap; // 画面遷移設定
};

#endif // SCREENTRANSITIONCONTROLLER_H
