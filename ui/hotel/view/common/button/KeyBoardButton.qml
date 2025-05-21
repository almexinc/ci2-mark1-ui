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
    property string textColor: "#333333"
    property string textColorSelected: "#ffffff"
    property int labelLeftMargin: 0
    property int labelRightMargin: 0
    gradientColor: "white"
    buttonRadius: 15

    Rectangle {
        color: "transparent"
        border.color: "#ed6d94"
        border.width: _optionButton.isSelected ? 0 : 1
        radius: buttonRadius
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#7f888e"
        border.width: _optionButton.isSelected ? 0 : 2
        radius: buttonRadius
    }
    Rectangle {
        anchors.margins: 1
        anchors.fill: parent
        color: "transparent"
        border.color: _optionButton.gradientColor === "white" ? "#ccffffff" : "#33ffffff"
        border.width: _optionButton.isSelected ? 0 : 3
        radius: buttonRadius
    }

    DefaultText {
        id: _labelText
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            leftMargin: _optionButton.labelLeftMargin
            rightMargin: _optionButton.labelRightMargin
        }
        text: _optionButton.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: _optionButton.isSelected ? _optionButton.textColorSelected : _optionButton.textColor
        font {
            bold: true
            pixelSize: _optionButton.fontPixelSize

        }
        languageCode: _optionButton.languageCode
    }
}
