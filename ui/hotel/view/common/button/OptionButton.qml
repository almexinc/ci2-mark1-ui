import QtQuick 2.15
import QtQuick.Controls 2.15

import "../base"
import "../text"

GradientButton {
    id: _optionButton
    property string buttonText: ""
    property int fontPixelSize: 35
    property string languageCode: "ja"
    property bool isClicked: false
    width: 100
    gradientColor: "white"
    buttonRadius: 20


    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#7f888e"
        border.width: 2
        radius: 20
        visible: !isSelected
    }
    Rectangle {
        anchors.margins: 1
        anchors.fill: parent
        color: "transparent"
        border.color: "#fff"
        border.width: 1
        radius: 20
        visible: !isSelected
    }

    DefaultText {
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
        }
        text: _optionButton.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font {
            bold: true
            pixelSize: _optionButton.fontPixelSize
        }
        languageCode: _optionButton.languageCode
    }
}
