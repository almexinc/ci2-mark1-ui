/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick 6.5
import QtQuick.Controls 6.5

import Almex.Hotel 1.0

Item {

    property string qmlFileName: "m0_0_0_InitPage"

    StackView.onActivating: console.log("StackView.onActivating:" + qmlFileName)
    StackView.onActivated: console.log("StackView.onActivated:" + qmlFileName)
    StackView.onDeactivating: console.log("StackView.onDeactivating:" + qmlFileName)
    StackView.onDeactivated: console.log("StackView.onDeactivated:" + qmlFileName)
    StackView.onRemoved: console.log("StackView.onRemoved:" + qmlFileName)

    Component.onCompleted: console.log("Component.onCompleted:" + qmlFileName)

    Rectangle {
        id: _rect
        width: 100
        height: 100
        color: "blue"
    }

    Text {
        id: _text
        anchors.centerIn: parent
        text: qsTr("こんにちは")
        font.pixelSize: 20
        color: "black"
    }

    M0_0_0_InitPage {
        id: _vm
    }

    // 5秒後に発火する
    Timer {
        id: _timer
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            console.log("Timer triggered")
            _vm.nextScreen()
        }
    }
}
