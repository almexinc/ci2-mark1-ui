#ifndef UISETTINGCONTROLLER_H
#define UISETTINGCONTROLLER_H

#include <QObject>

class UiSettingController : public QObject
{
    Q_OBJECT

public:
    UiSettingController(const UiSettingController &)            = delete;
    UiSettingController &operator=(const UiSettingController &) = delete;
    UiSettingController(UiSettingController &&)                 = delete;
    UiSettingController &operator=(UiSettingController &&)      = delete;

    static UiSettingController *getInstance();

    void init(const QString &filePath);

signals:

private:
    UiSettingController();

    QString _filePath;
};

#endif // UISETTINGCONTROLLER_H
