/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "testtopic.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>

#include "common/src/utils/logger.h"

#define REQUEST_TOPIC_NAME "/almex/device/test/request_test_topic"
#define RESULT_TOPIC_NAME  "/almex/device/test/result_test_topic"
#define NOTICE_TOPIC_NAME  "/almex/device/test/notice_test_topic"

TestTopic::TestTopic(QObject *parent)
    : QObject { parent }
{
    this->_receiveTopicName.append(RESULT_TOPIC_NAME);
    this->_receiveTopicName.append(NOTICE_TOPIC_NAME);
}

/**
 * @brief 受け取ったメッセージを解析する
 *
 * @param topicName トピック名
 * @param message メッセージ本文
 */
CheckTopicType TestTopic::checkTopic(const QString &topicName, const QByteArray &message)
{
    if (topicName == this->_receiveTopicName.at(0)) {
        auto [resultData, isParseError] = ResultData::create(message);

        if (isParseError) {
            // 処理しない。開発中の意図しないパースエラーが発生した場合にログを出す事を目的としている
            // パースエラー→そもそも送信側の構造が意図しないもの、というのは実運用上で起きてもカバーできない
            Logger::error(metaObject()->className(), __FUNCTION__, "パースエラーが発生した。トピック名: " + topicName + ", メッセージ: " + message);
        }

        this->_resultData = resultData;

        return CheckTopicType::E_RESULT;

    } else if (topicName == this->_receiveTopicName.at(1)) {
        auto [noticeData, isParseError] = NoticeData::create(message);
        if (isParseError) {
            // 処理しない。開発中の意図しないパースエラーが発生した場合にログを出す事を目的としている
            // パースエラー→そもそも送信側の構造が意図しないもの、というのは実運用上で起きてもカバーできない
            Logger::error(metaObject()->className(), __FUNCTION__, "パースエラーが発生した。トピック名: " + topicName + ", メッセージ: " + message);
        }

        this->_noticeData = noticeData;

        return CheckTopicType::E_NOTICE;
    }

    return CheckTopicType::E_NONE;
}

/**
 * @brief 読み込みの開始通知
 *
 * @return std::pair<QString, QByteArray> first:トピック名, second:メッセージ本文。JSON形式。
 */
std::pair<QString, QByteArray> TestTopic::requestStartRead()
{
    QString     topicName = REQUEST_TOPIC_NAME;
    QJsonObject jsonObj   = {
        { "request", "start_read" },
    };

    return { topicName, QJsonDocument(jsonObj).toJson() };
}

//
// ResultData
//

TestTopic::ResultData::ResultData()
{
    this->_readId = "";
}

std::pair<TestTopic::ResultData, bool> TestTopic::ResultData::create(const QByteArray &message)
{
    /*
        構造
        {
            "read_id": "test_read_id"
        }
    */

    ResultData data;

    QJsonParseError parser;
    QJsonDocument   doc = QJsonDocument::fromJson(message, &parser);
    if (parser.error != QJsonParseError::NoError) {
        Logger::error("ResultData", __FUNCTION__, "JSON パースエラー: " + parser.errorString());
        return { data, false };
    }

    //
    // JSONの解析
    //
    QJsonObject jsonObj = doc.object();

    data._readId = jsonObj["read_id"].toString();

    return { data, true };
}

//
// NoticeData
//

TestTopic::NoticeData::NoticeData()
{
    this->_readId                = "";
    this->_result._resultCode    = 0;
    this->_result._resultMessage = "";
}

std::pair<TestTopic::NoticeData, bool> TestTopic::NoticeData::create(const QByteArray &message)
{
    /*
        構造
        {
            "read_id": "test_read_id",
            "result": {
                "result_code": 0,
                "result_message": "OK"
            }
        }
    */

    NoticeData data;

    QJsonParseError parser;
    QJsonDocument   doc = QJsonDocument::fromJson(message, &parser);
    if (parser.error != QJsonParseError::NoError) {
        qWarning() << "JSON parse error:" << parser.errorString();
        Logger::error("NoticeData", __FUNCTION__, "JSON パースエラー: " + parser.errorString());
        return { data, false };
    }

    //
    // JSONの解析
    //
    QJsonObject jsonObj = doc.object();
    data._readId        = jsonObj["read_id"].toString();

    QJsonObject resultObj       = jsonObj["result"].toObject();
    data._result._resultCode    = resultObj["result_code"].toInt();
    data._result._resultMessage = resultObj["result_message"].toString();

    return { data, true };
}
