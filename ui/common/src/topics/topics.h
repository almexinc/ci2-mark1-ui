#ifndef TOPICS_H
#define TOPICS_H

#include <QObject>

/**
 * @brief 各トピックで checkTopic を行った際の戻り値
 *
 */
enum class CheckTopicType {
    E_NONE,   // 該当しないトピック名
    E_NOTICE, // noticeトピック
    E_RESULT, // resultトピック
};

class Topics : public QObject
{
    Q_OBJECT
public:
    explicit Topics(QObject *parent = nullptr);

    /**
     * @brief サブスクライブ対象となるトピック名を取得する
     *
     * @return QList<QString> トピック名リスト
     */
    static QList<QString> getResultTopicNameList();

signals:
};

#endif // TOPICS_H
