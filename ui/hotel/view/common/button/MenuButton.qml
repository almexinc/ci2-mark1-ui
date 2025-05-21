import QtQuick 2.15
import QtQuick.Controls 2.15

import "../base"
import "../text"

GradientButton {
    id: _menuButton
    property string buttonText: ""
    property int fontPixelSize: 0
    property string languageCode: "ja"
    property bool isClicked: false
    property string subText: ""
    property string icon: ""
    property string subFontPixelSize: "38"
    width: 100
    gradientColor: "goldLg"
    buttonRadius: 20

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#7f888e"
        border.width: 1
        radius: 20
        visible: !isSelected
    }

    Rectangle {
        anchors.margins: 1
        anchors.fill: parent
        color: "transparent"
        border.color: "#fff"
        border.width: 2
        radius: 18
        visible: !isSelected
    }


    Column {

        spacing: 0
        anchors.centerIn: parent
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
        }

        DefaultText {
            id: _baseButtonText
            text: _menuButton.buttonText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Window.onWidthChanged: changeFontSize()
            Window.onHeightChanged: changeFontSize()
            font {
                bold: true
            }
            languageCode: _menuButton.languageCode
            anchors.horizontalCenter: parent.horizontalCenter
            function changeFontSize() {
                _baseButtonText.font.pixelSize = Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? _menuButton.fontPixelSize * 0.8 : _menuButton.fontPixelSize
            }
        }

        DefaultText {
            text: _menuButton.subText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font {
                bold: false
                pixelSize: _menuButton.subFontPixelSize * 0.8

            }
            languageCode: _menuButton.languageCode
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    BaseImage {
        anchors {
            right: parent.right; rightMargin:30
            bottom: parent.bottom; bottomMargin:20
        }
        source: _menuButton.icon
    }




}
