#ifndef MQTTCONTROLLER_H
#define MQTTCONTROLLER_H

#include <QObject>
#include <QtMqtt/qmqttclient.h>

class MqttController : public QObject
{
    Q_OBJECT
public:
    MqttController(const MqttController &)            = delete;
    MqttController &operator=(const MqttController &) = delete;
    MqttController(MqttController &&)                 = delete;
    MqttController &operator=(MqttController &&)      = delete;

    static MqttController *getInstance();

signals:

private:
    MqttController();

    QMqttClient _qMqttClient;
};

#endif // MQTTCONTROLLER_H
