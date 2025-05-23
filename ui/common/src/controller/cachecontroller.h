#ifndef CACHECONTROLLER_H
#define CACHECONTROLLER_H

#include <QObject>

class CacheController : public QObject
{
    Q_OBJECT

public:
    CacheController(const CacheController &)            = delete;
    CacheController &operator=(const CacheController &) = delete;
    CacheController(CacheController &&)                 = delete;
    CacheController &operator=(CacheController &&)      = delete;

    static CacheController *getInstance();

    void clear();

    //////////////////////////////////////////////
    // 画面遷移後も保持したいメンバーをここから追加する
    // clear()に初期化する処理も記載すること
    //////////////////////////////////////////////

    /* 例）
        // 予約情報の保持
        public:
            void setReadId(const QString &readId) { this->_readId = readId; }
            QString getReadId() const { return this->_readId; }
        private:
            QString _readId;

        // 電話番号の保持
        public:
            void setPhoneNumber(const QString &phoneNumber) { this->_phoneNumber = phoneNumber; }
            QString getPhoneNumber() const { return this->_phoneNumber; }
        private:
            QString _phoneNumber;
    */

    //////////////////////////////////////////////
    // ここまで。
    //////////////////////////////////////////////

public:
signals:

private:
    CacheController();
};

#endif // CACHECONTROLLER_H
