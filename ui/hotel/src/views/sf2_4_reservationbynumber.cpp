/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#include "sf2_4_reservationbynumber.h"

#include "common/src/utils/logger.h"

SF2_4_ReservationByNumber::SF2_4_ReservationByNumber(QObject *parent)
    : QObject { parent }
{
}

/**
 * @brief 画面が生成されてから行われるC++側の初期化処理
 */
void SF2_4_ReservationByNumber::init()
{
    Logger::info(metaObject()->className(), __FUNCTION__, "初期化処理開始");

    // TODO: 画面に応じた処理を入れる

    // 初期化完了通知
    Logger::info(metaObject()->className(), __FUNCTION__, "初期化処理完了");
    emit initialized();
}
