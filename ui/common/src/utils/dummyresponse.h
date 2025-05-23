/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef DUMMYRESPONSE_H
#define DUMMYRESPONSE_H

#include <QDir>
#include <QObject>

class DummyResponse : public QObject
{
    Q_OBJECT
public:
    explicit DummyResponse(QObject *parent = nullptr);

    void init(const QString &dirPath, QList<QString> useDummyList);

    /**
     * @brief 送信したトピックを元にダミーレスポンスを送信する。
     * @param sendTopicName どのダミーを使うかで使用するトピック名
     */
    void sendDummyResponse(const QString sendTopicName);

signals:
    /**
     * @brief getDummyResponseの後、ダミーが有効であれば送信するシグナル。
     **/
    void dummyPublish(const QString &topicName, const QByteArray &message);

private:
    QDir           _dir;
    QList<QString> _useDummyCategoryList; // 使用するダミーのカテゴリ名
};

#endif // DUMMYRESPONSE_H
