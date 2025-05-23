/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef TESTTOPIC_H
#define TESTTOPIC_H

#include <QObject>
#include <utility>

#include "topics.h"

class TestTopic : public QObject
{
    Q_OBJECT
public: // 公開構造体定義
    /**
     * @brief result_～トピックの受信メッセージ
     */
    struct ResultData {
        QString _readId;

        ResultData();
        static std::pair<ResultData, bool> create(const QByteArray &message);
    };

    /**
     * @brief notice_～トピックの受信メッセージ
     */
    struct NoticeData {
        QString _readId;

        struct Result {
            int     _resultCode;
            QString _resultMessage;
        } _result;

        NoticeData();
        static std::pair<NoticeData, bool> create(const QByteArray &message);
    };

public:
    explicit TestTopic(QObject *parent = nullptr);

    /**
     * @brief 受信するトピック名。
     * 新規作成時はtopics.cppのgetResultTopicNameListに追加すること。
     * 一つのトピックでnoticeとresultがある場合はQList<QString>にすること。
     */
    QList<QString> _receiveTopicName;

    /**
     * @brief 受け取ったメッセージを解析する
     *
     * @param topicName トピック名
     * @param message メッセージ本文
     */
    CheckTopicType checkTopic(const QString &topicName, const QByteArray &message);

    /**
     * @brief 読み込みの開始通知
     *
     * @return std::pair<QString, QByteArray> first:トピック名, second:メッセージ本文
     */
    std::pair<QString, QByteArray> requestStartRead();

    ResultData getResultData() const { return this->_resultData; }
    NoticeData getNoticeData() const { return this->_noticeData; }

signals:

private:
    ResultData _resultData;
    NoticeData _noticeData;
};

#endif // TESTTOPIC_H
