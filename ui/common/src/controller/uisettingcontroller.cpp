#include "uisettingcontroller.h"

#include <yaml-cpp/yaml.h>

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

    YAML::Node config;
    try {
        config = YAML::LoadFile(filePath.toStdString());
    } catch (const YAML::Exception &e) {
        Logger::error(metaObject()->className(), __FUNCTION__, "YAMLファイルの読み込みに失敗した。ファイルパス: " + filePath + ", エラーメッセージ: " + QString::fromStdString(e.what()));
        return;
    }
    Logger::info(metaObject()->className(), __FUNCTION__, "YAMLファイルの読み込みに成功した。ファイルパス: " + filePath);
}