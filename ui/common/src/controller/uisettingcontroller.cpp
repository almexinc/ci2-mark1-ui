/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "uisettingcontroller.h"

#include "common/src/utils/logger.h"

UiSettingController::UiSettingController()
    : QObject { nullptr }
{
}

UiSettingController *UiSettingController::getInstance()
{
    static UiSettingController instance;
    return &instance;
}

void UiSettingController::init(const QString &filePath)
{
    this->_filePath = filePath;

    try {
        this->_config = YAML::LoadFile(filePath.toStdString());
    } catch (const YAML::Exception &e) {
        Logger::error(metaObject()->className(), __FUNCTION__, "YAMLファイルの読み込みに失敗した。ファイルパス: " + filePath + ", エラーメッセージ: " + QString::fromStdString(e.what()));
        return;
    }

    // ルートノードがマップ型であることを確認
    if (!this->_config.IsMap()) {
        // YAML形式ではない以外に、ファイルが全てコメントアウトや空である場合にも通る

        Logger::error(metaObject()->className(), __FUNCTION__, "設定ファイルが正しいフォーマットではありません。ファイルパス: " + filePath);
        return;
    }

    Logger::info(metaObject()->className(), __FUNCTION__, "YAMLファイルの読み込みに成功した。ファイルパス: " + filePath);
}

/**
 * @brief ログ保存日数を取得する
 *
 * @return int ログ保存日数。
 */
int UiSettingController::getLogSaveDays() const
{
    // 構造
    // log_setting:
    //   save_days: 30

    try {
        auto saveDays = this->_config["log_setting"]["save_days"].as<int>();
        Logger::info(metaObject()->className(), __FUNCTION__, "ログ保存日数: " + QString::number(saveDays));
        return saveDays;
    } catch (const YAML::Exception &e) {
        // YAMLの例外条件
        // 1. log_setting、またはsave_daysが存在しない場合
        // 2. save_daysが整数型でない場合（但し、"123"などint型に変換できる文字列のみの構成の場合はint値として取得される模様）

        Logger::error(metaObject()->className(), __FUNCTION__, "ログ設定が見つかりません。デフォルト値：365日を返します。エラーメッセージ: " + QString::fromStdString(e.what()));
    }

    return 365;
}

/**
 * @brief MQTTの接続設定を取得する
 * @return std::tuple<QString, quint16, QString, QString> ホスト名、ポート番号、ユーザ名、パスワード
 */
std::tuple<QString, quint16, QString, QString> UiSettingController::getMqttSetting() const
{
    // 構造
    // mqtt:
    //   # MQTTの接続先URL
    //   host_name: localhost
    //   # MQTTのポート番号
    //   port: 1883
    //   # MQTTのユーザ名
    //   user: user
    //   # MQTTのパスワード
    //   password: password

    try {
        auto hostName = QString::fromStdString(this->_config["mqtt"]["host_name"].as<std::string>());
        auto port     = static_cast<quint16>(this->_config["mqtt"]["port"].as<int>());
        auto user     = QString::fromStdString(this->_config["mqtt"]["user"].as<std::string>());
        auto password = QString::fromStdString(this->_config["mqtt"]["password"].as<std::string>());

        Logger::info(metaObject()->className(), __FUNCTION__, "MQTT設定: " + hostName + ", " + QString::number(port) + ", " + user + ", " + password);
        return { hostName, port, user, password };
    } catch (const YAML::Exception &e) {
        // YAMLの例外条件
        // 1. mqtt、またはhost_name、port、user、passwordが存在しない場合
        // 2. portが整数型でない場合（但し、"123"などint型に変換できる文字列のみの構成の場合はint値として取得される模様）

        Logger::error(metaObject()->className(), __FUNCTION__, "MQTT設定が見つかりません。デフォルト値を返します。エラーメッセージ: " + QString::fromStdString(e.what()));
    }
    return { "localhost", 1883, "user", "password" };
}

/**
 * @brief ダミーの使用有無を取得する。
 * QList<QString>に含まれるカテゴリーが利用される。
 */
QList<QString> UiSettingController::getDummyResponse() const
{
    // 構造
    // autotest:
    //   qr_service: true
    //   print_service: false

    try {
        QList<QString> useDummyList;
        for (const auto &category : this->_config["autotest"]) {
            // 使用するダミーの設定かどうかを取得する
            if (category.second.as<bool>()) {
                // 定義してあるパラメータ名そのものを取得して設定する
                useDummyList.append(QString::fromStdString(category.first.as<std::string>()));
            }
        }

        // autotestでtrueになっているパラメータ名の一覧を返却する
        return useDummyList;
    } catch (const YAML::Exception &e) {
        // YAMLの例外条件
        // 1. autotestが存在しない場合
        // 2. autotestの中にtrue/falseが存在しない場合

        Logger::error(metaObject()->className(), __FUNCTION__, "ダミー設定が見つかりません。デフォルト値を返します。エラーメッセージ: " + QString::fromStdString(e.what()));
    }

    // 空
    return {};
}