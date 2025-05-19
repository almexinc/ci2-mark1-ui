#include "te0_0_1_testidle.h"

TE0_0_1_TestIdle::TE0_0_1_TestIdle(QObject *parent)
    : QObject { parent }
{
    qInfo() << "TE0_0_1_TestIdle::TE0_0_1_TestIdle: ";
}

TE0_0_1_TestIdle::~TE0_0_1_TestIdle()
{
    qInfo() << "TE0_0_1_TestIdle::~TE0_0_1_TestIdle: ";
}
