/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick 6.5
import QtQuick.Controls 6.5

Item {

    property string qmlFileName: "m0_0_0_InitPage"

    StackView.onActivating: console.log("StackView.onActivating:" + qmlFileName)
    StackView.onActivated: console.log("StackView.onActivated:" + qmlFileName)
    StackView.onDeactivating: console.log("StackView.onDeactivating:" + qmlFileName)
    StackView.onDeactivated: console.log("StackView.onDeactivated:" + qmlFileName)
    StackView.onRemoved: console.log("StackView.onRemoved:" + qmlFileName)

    Component.onCompleted: console.log("Component.onCompleted:" + qmlFileName)

    Rectangle {
        id: rect
        width: 100
        height: 100
        color: "blue"
    }

    Text {
        id: text
        anchors.centerIn: parent
        text: qsTr("こんにちは")
        font.pixelSize: 20
        color: "black"
    }
}
