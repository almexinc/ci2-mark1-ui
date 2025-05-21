import QtQuick
import QtQuick.Controls.Basic
import "../contents"
import "../base"
import "../text"

GradientButton {
    id:_optionButton
     property string buttonText: ""
    property int fontPixelSize: 28
    property string languageCode: "ja"
    width: 154
    height: parent.height
    gradientColor: "white"
    buttonRadius: 20

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#7f888e"
        border.width: 1
        radius: 20
    }
    Rectangle {
        anchors.margins: 2
        anchors.fill: parent
        color: "transparent"
        border.color: "#fff"
        border.width: 2
        radius: 18
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
        color: "#333333"
        font {
            bold: true
            pixelSize: _optionButton.fontPixelSize

        }
        languageCode: _optionButton.languageCode
    }

}
