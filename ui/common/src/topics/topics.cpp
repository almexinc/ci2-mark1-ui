/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "topics.h"

#include "testtopic.h"

Topics::Topics(QObject *parent)
    : QObject { parent }
{
}

/**
 * @brief サブスクライブ対象となるトピック名を取得する
 *
 * @return QList<QString> トピック名リスト
 */
QList<QString> Topics::getResultTopicNameList()
{
    QList<QString> result;

    result.append(TestTopic()._receiveTopicName);

    return result;
}
