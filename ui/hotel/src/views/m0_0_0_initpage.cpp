#include "m0_0_0_initpage.h"

#include "common/src/controller/sharedcontroller.h"

M0_0_0_InitPage::M0_0_0_InitPage(QObject *parent)
    : QObject { parent }
{
    qInfo() << "M0_0_0_InitPage::M0_0_0_InitPage: ";
}

M0_0_0_InitPage::~M0_0_0_InitPage()
{
    qInfo() << "M0_0_0_InitPage::~M0_0_0_InitPage: ";
}

void M0_0_0_InitPage::nextScreen()
{
    emit SharedController::getInstance() -> qmlFilePushScreen("te0_0_1_TestIdle");
}