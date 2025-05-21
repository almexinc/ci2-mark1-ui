import QtQuick
import "../base"
import "../text"

Rectangle {
    id: _flatButton
    property string buttonText: ""
    property string bgColor: constants.keyColor
    property string borderColor: constants.keyColor
    property int fontPixelSize: 18
    signal clicked()
    width: 145
    height: 50
    border {
        color: _flatButton.borderColor
        width: 2
    }
    radius: 5
    color: _flatButton.bgColor

    MouseArea {
        id: _mouseArea
        property bool isPressed: false
        anchors.fill: parent
        onVisibleChanged: this.isPressed = false
        onClicked: {
            _flatButton.clicked()
        }
    }
}
