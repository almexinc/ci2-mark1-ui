/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick
import QtQuick 2.15
import QtQuick.Controls 2.15
import "../contents"

Button {
    id: _top

    // 文字表示に関する設定。
    property string languageCode: "ja"
    // property string fontWeight: "regular"   // Regularのみの想定なので使用しない。
    property alias textFont: _text.font
    property alias textColor: _text.color
    property alias textStyle: _text

    // ボタンの状態。
    property bool disabled: false
    property bool selected: false

    // 非活性時の不透明度。
    property real disableOpacity: 0.5

    width: 200


    contentItem: Item {
        BaseText {
            id: _text
            languageCode: _top.languageCode
            // fontWeight: _top.fontWeight
            text: _top.text
            anchors.fill: parent
            color: constants.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            // wrapMode: Text.WordWrap
        }
    }

    states: [
        State {
            name: "disable"
            when: disabled
            PropertyChanges {
                target: _top
                enabled: false
                opacity: disableOpacity
            }
        },
        State {
            name: "selected"
            when: selected
            PropertyChanges {
                target: _top
                enabled: false
            }
        }
    ]
}
