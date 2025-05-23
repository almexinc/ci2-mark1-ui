#include "cachecontroller.h"

CacheController::CacheController()
    : QObject { nullptr }
{
}

void CacheController::clear()
{
}

CacheController *CacheController::getInstance()
{
    static CacheController instance;
    return &instance;
}