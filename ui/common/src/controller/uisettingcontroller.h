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

    /**
     * @brief MQTTの接続設定を取得する
     * @return std::tuple<QString, quint16, QString, QString> ホスト名、ポート番号、ユーザ名、パスワード
     */
    std::tuple<QString, quint16, QString, QString> getMqttSetting() const;

    /**
     * @brief ダミーの使用有無を取得する。
     * QList<QString>に含まれるカテゴリーが利用される。
     */
    QList<QString> getDummyResponse() const;

signals:

private:
    UiSettingController();

    QString    _filePath;
    YAML::Node _config;
};

#endif // UISETTINGCONTROLLER_H
