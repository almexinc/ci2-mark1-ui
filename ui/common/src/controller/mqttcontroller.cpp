#include "mqttcontroller.h"

MqttController::MqttController()
{
    this->_qMqttClient.setAutoKeepAlive(true);
    this->_qMqttClient.setKeepAlive(1000);
}

MqttController *MqttController::getInstance()
{
    static MqttController instance;
    return &instance;
}
