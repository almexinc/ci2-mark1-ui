/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick 2.15

Item {
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
