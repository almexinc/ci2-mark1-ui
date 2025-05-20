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