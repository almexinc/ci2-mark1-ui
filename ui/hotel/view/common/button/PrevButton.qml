import QtQuick
import QtQuick.Controls.Basic
import "../contents"
import "../base"
import "../text"

GradientButton {
    id: _optionButton
    property string buttonText: "戻る"
    property int fontPixelSize: 28
    property string languageCode: "ja"
    property bool isClicked: false
    width: 200
    height: parent.height
    gradientColor: "prev"
    buttonRadius: 20


    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#7f888e"
        border.width: 2
        radius: 20
    }
    Rectangle {
        anchors.margins: 1
        anchors.fill: parent
        color: "transparent"
        border.color: "#fff"
        border.width: 1
        radius: 20
    }


    Row {
        spacing: 10
        anchors.centerIn: parent  // 親の上下左右中央に配置

        BaseImage {
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../../img/icon/arron_prev.png"
        }

        DefaultText {
            anchors.verticalCenter: parent.verticalCenter
            text: _optionButton.buttonText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#ffffff"
            font {
                bold: true
                pixelSize: _optionButton.fontPixelSize
            }
            languageCode: _optionButton.languageCode
        }
    }
}
