import QtQuick 2.15
import QtQuick.Controls 2.15

import "../base"
import "../text"

SolidButton {
    id: _videoButton
    property int fontPixelSize: 0
    property string languageCode: "ja"
    property bool isClicked: false
    buttonColor: constants.solidColorRed

    DefaultText {
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
        }
        text: qsTrr("ビデオ通話")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font {
            pixelSize: _videoButton.fontPixelSize
        }
        languageCode: _videoButton.languageCode
        color: "#ffffff"
    }
}
