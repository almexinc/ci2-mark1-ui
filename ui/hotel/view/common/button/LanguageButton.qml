import QtQuick 2.15
import QtQuick.Controls 2.15

import "../base"
import "../text"

GradientButton {
    id: _languageButton
    width: 70
    height: parent.height
    property string buttonText: ""
    property int fontPixelSize: 0
    property string languageCode: "ja"
    gradientColor: "white"
    selectedColor: "#996b09"
    isSelected: isSelected
    buttonRadius: 20

    anchors {
        top: parent.top;topMargin: -20
    }



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


    DefaultText {
        id: _languageText
        width: parent.width
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            bottom: parent.bottom
        }
        text: _languageButton.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font {
            bold: true
            pixelSize: 25

            letterSpacing: 0.4
        }
        lineHeight: 0.8
        color: isSelected ? "#ffffff" : "#001e33"
        languageCode: _languageButton.languageCode

        Window.onWidthChanged: changeFontSize()
        Window.onHeightChanged: changeFontSize()

        function changeFontSize() {
            _languageText.font.pixelSize = Window.width < constants.breakPointWidth ? 18 : 25
        }
    }


    BaseImage {
        anchors {

            right: parent.right
            left: parent.left
            bottomMargin: (Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight) ? 15 : 20
            bottom: parent.bottom
        }
        fillMode: Image.PreserveAspectFit
        source: "../../../img/icon/selected.png"
        visible: isSelected
    }
}
