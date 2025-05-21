import QtQuick
import QtQuick.Controls
import "../base"
import "../parts"

BaseTextField {
    id: _textField
    readonly property Gradient gradientGray: Gradient {
        // 白のグラデーション
        GradientStop { position: 0; color: "#b3b3b3" }
        GradientStop { position: 0.125; color: "#f0f0f0" }
    }
    readonly property Gradient gradientWht: Gradient {
        // 白のグラデーション
        GradientStop { position: 0; color: "#b3b3b3" }
        GradientStop { position: 0.125; color: "#ffffff" }
    }
    property Gradient gradientColor: gradientGray
    font.pixelSize: 28
    placeholderText: ""
    placeholderTextColor: "#888888"
    leftPadding: 15
    rightPadding: 15
    background: Rectangle {
        anchors {
            fill: parent
        }
        border {
            color: "#a4a4a4"
            width: 1
        }
        radius: 20
        gradient: _textField.gradientColor
    }

    Rectangle {
        anchors.margins: 1
        anchors.fill: parent
        color: "transparent"
        border.color: "#fff"
        border.width: 2
        radius: 20
    }
}
