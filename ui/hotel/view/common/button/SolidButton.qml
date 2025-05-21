import QtQuick
import QtQuick.Controls.Basic
import "../contents"
import "../base"

BaseButton {
    id: _solidButton

    property string buttonColor: constants.solidColorDkGry
    textColor: constants.textContrastColor

    // 選択済み表示の色
    property string selectedColor: constants.solidColorGry
    property string selectedTextColor: constants.textContrastColor

    property bool isSelected: false
    signal clicked()

    // backgroundプロパティではなく、直接Rectangleを定義
    Rectangle {
        id: _baseBackGround
        anchors.fill: parent
        color: buttonColor
        rotation: mouseArea.pressed ? 180 : 0
        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        onClicked: {
            _solidButton.clicked()
        }
    }

    states: [
        State {
            name: "solidButtonSelected"
            when: isSelected
            PropertyChanges {
                target: _solidButton
                buttonColor: undefined
                textColor: selectedColor
            }
        }
    ]

//    background:
//        Rectangle {
//        id: _baseRect
//        color: buttonColor
//        radius: 0

//        states: [
//            State {
//                name: "selected"
//                when: selected
//                PropertyChanges {
//                    target: _baseRect
//                    color: selectedColor
//                }
//                PropertyChanges {
//                    target: _top
//                    textColor: selectedTextColor
//                }
//            }
//        ]
//    }
}
