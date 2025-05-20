#ifndef UISETTINGCONTROLLER_H
#define UISETTINGCONTROLLER_H

#include <QObject>
#include <yaml-cpp/yaml.h>

class UiSettingController : public QObject
{
    Q_OBJECT

public:
    UiSettingController(const UiSettingController &)            = delete;
    UiSettingController &operator=(const UiSettingController &) = delete;
    UiSettingController(UiSettingController &&)                 = delete;
    UiSettingController &operator=(UiSettingController &&)      = delete;

    static UiSettingController *getInstance();

    void init(const QString &filePath);

    /**
     * @brief ログ保存日数を取得する
     *
     * @return int ログ保存日数。
     */
    int getLogSaveDays() const;

signals:

private:
    UiSettingController();

    QString    _filePath;
    YAML::Node _config;
};

#endif // UISETTINGCONTROLLER_H
