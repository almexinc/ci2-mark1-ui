#include "dummyresponse.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QPointer>
#include <QTimer>

DummyResponse::DummyResponse(QObject *parent)
    : QObject { parent }
{
}

void DummyResponse::init(const QString &dirPath, QList<QString> useDummyList)
{
    // ベースとなるパスを設定する
    this->_dir.setPath(dirPath);
    if (!this->_dir.exists()) {
        this->_dir.mkpath(this->_dir.absolutePath());
    }

    // 使用するカテゴリー名を設定する
    this->_useDummyCategoryList = useDummyList;
}

/**
 * @brief 送信したトピックを元にダミーレスポンスを送信する。
 * @param sendTopicName どのダミーを使うかで使用するトピック名
 */
void DummyResponse::sendDummyResponse(const QString sendTopicName)
{
    if (this->_useDummyCategoryList.isEmpty()) {
        // ダミーが一つも有効でなければそもそも利用しない
        return;
    }

    // JSON ファイルを取得
    QFileInfoList jsonFiles = this->_dir.entryInfoList({ "*.json" }, QDir::Files);

    for (const QFileInfo &fileInfo : qAsConst(jsonFiles)) {
        QFile file(fileInfo.absoluteFilePath());
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            continue;
        }

        QByteArray fileData = file.readAll();
        file.close();

        QJsonDocument doc = QJsonDocument::fromJson(fileData);
        if (!doc.isObject()) {
            continue;
        }

        QJsonObject rootObj = doc.object();

        // トピック名とカテゴリーの一致を確認
        if (rootObj["target"].toString() != sendTopicName || !this->_useDummyCategoryList.contains(rootObj["category"].toString())) {
            continue;
        }

        QList<QJsonObject> *responseList = new QList<QJsonObject>();
        for (QJsonArray responses = rootObj["responses"].toArray(); const QJsonValue &responseValue : qAsConst(responses)) {
            QJsonObject responseObj = responseValue.toObject();
            responseList->append(responseObj);
        }

        // 送信するダミーJSONを取り出して送信したら次のダミーJSONを取り出して送信……をするタイマー
        QPointer<QTimer> loopSender = new QTimer(this);
        loopSender->setSingleShot(true);
        connect(loopSender, &QTimer::timeout, this, [this, responseList, loopSender]() {
            if (!loopSender) {
                delete responseList;
                return;
            }
            if (responseList->isEmpty()) {
                loopSender->stop();
                loopSender->deleteLater();
                delete responseList;
                return;
            }

            auto responseObj = responseList->takeAt(0);

            QString     sendTopic       = responseObj["sendTopic"].toString();
            int         startDelayMs    = responseObj.value("startDelayMs").toInt(0);
            QJsonObject responseContent = responseObj["response"].toObject();

            QByteArray dummyJsonMessage = QJsonDocument(responseContent).toJson();

            // QTimer を使用して遅延送信
            QTimer::singleShot(startDelayMs, this, [this, sendTopic, dummyJsonMessage, loopSender]() {
                emit this->dummyPublish(sendTopic, dummyJsonMessage);
                if (loopSender) {
                    loopSender->start(0); // 次のレスポンスを送信するために再度タイマーを開始
                }
            });
        });
        loopSender->start(0);

        // 一致すれば他のファイルは見ないので break
        break;
    }
}
