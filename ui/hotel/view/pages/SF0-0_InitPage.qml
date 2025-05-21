/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick
import QtQuick.Controls

import Almex.Hotel 1.0

Item {
    property string qmlFileName: ""// push時に設定される

    // StackView.onActivating: sharedController.qmlLogInfo("StackView.onActivating:" + qmlFileName)
    // StackView.onActivated: sharedController.qmlLogInfo("StackView.onActivated:" + qmlFileName)
    // StackView.onDeactivating: sharedController.qmlLogInfo("StackView.onDeactivating:" + qmlFileName)
    // StackView.onDeactivated: sharedController.qmlLogInfo("StackView.onDeactivated:" + qmlFileName)

    StackView.onRemoved: {
        sharedController.qmlLogInfo("StackView.onRemoved: " + qmlFileName)
        _vm.onRemoved()
    }

    Component.onCompleted: {
        sharedController.qmlLogInfo("Component.onCompleted: " + qmlFileName)
    }

    SF0_0_InitPage {
        id: _vm
    }
}