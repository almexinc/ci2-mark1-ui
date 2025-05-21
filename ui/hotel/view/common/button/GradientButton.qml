import QtQuick
import QtQuick.Controls.Basic
import "../contents"
import "../base"
import "../text"

Item {
    id: _gradientButton

    property real embossWidth: 10   // ボタン下部縁の高さ。
    property int buttonRadius: 5
    property string gradientColor: "white"  // 色の指定。 white, goldSm, goldLg の３種。
    property alias buttonGradient: _baseGradient.gradient   // グラデーションの指定。 未定義の色を使用する場合にGradientを直接記述。
    property bool isSelected: false
    property bool push: false
    signal clicked()

    // グラデーションの定義。
    // 白のグラデーション
    readonly property Gradient buttonGradientWht: Gradient {
        GradientStop { position: 0.7; color: constants.gradientColorWht[0] }
        GradientStop { position: 0.94; color: constants.gradientColorWht[1] }
        GradientStop { position: 1.0; color: constants.gradientColorWht[2] }
    }

    readonly property Gradient buttonGradientGldSm: Gradient {
        // ゴールドのグラデーション１。高さが短い場合に使用。
        GradientStop { position: 0.0; color: constants.gradientColorGldSm[0] }
        GradientStop { position: embossWidthRate; color: constants.gradientColorGldSm[1] }
        GradientStop { position: 1.0; color: constants.gradientColorGldSm[2] }
    }
    readonly property Gradient buttonGradientGldLg: Gradient {
        // ゴールドのグラデーション２。大きいボタンで使用。
        GradientStop { position: 0.0; color: constants.gradientColorGldLg[0] }
        GradientStop { position: 0.73 ; color: constants.gradientColorGldLg[1] }
        GradientStop { position: embossWidthRate; color: constants.gradientColorGldLg[2] }
        GradientStop { position: 1.0; color: constants.gradientColorGldLg[3] }
    }

    readonly property Gradient buttonGradientBlue: Gradient {
        // 青のグラデーション
        GradientStop { position: 0.0; color: constants.gradientColorBlue[0] }
        GradientStop { position: 0.15 ; color: constants.gradientColorBlue[1] }
        GradientStop { position: 0.7; color: constants.gradientColorBlue[2] }
        GradientStop { position: 1.0; color: constants.gradientColorBlue[3] }
    }
    readonly property Gradient buttonGradientBlue2: Gradient {
        // 青のグラデーション
        GradientStop { position: 0.0; color: constants.gradientColorBlue2[0] }
        GradientStop { position: 0.15 ; color: constants.gradientColorBlue2[1] }
        GradientStop { position: 0.7; color: constants.gradientColorBlue2[2] }
        GradientStop { position: 1.0; color: constants.gradientColorBlue2[3] }
    }
    readonly property Gradient buttonGradientRed: Gradient {
        // 赤のグラデーション（右から左）
        GradientStop { position: 1.0; color: constants.gradientColorRed[0] }
        GradientStop { position: 0.2; color: constants.gradientColorRed[1] }
        GradientStop { position: 0.2; color: constants.gradientColorRed[2] }
        GradientStop { position: 0.0; color: constants.gradientColorRed[3] }
    }

    readonly property Gradient buttonPrev: Gradient {
        // 赤のグラデーション（右から左）
        GradientStop { position: 1.0; color: constants.gradientColorPrev[0] }
        GradientStop { position: 0.8; color: constants.gradientColorPrev[1] }
        GradientStop { position: 0.2; color: constants.gradientColorPrev[2] }
        GradientStop { position: 0.0; color: constants.gradientColorPrev[3] }
    }


    property real embossWidthRate: (height - embossWidth) / height  // ボタン上部から下部エンボス部までの高さの割合。GradientStopで使用。

    // 選択済み表示の色
    property string selectedColor: "#996b09"
    property string selectedTextColor: constants.textContrastColor

    enum GradientColor {
        GoldLg,
        GoldSm,
        Blue,
        Blue2,
        White
    }

    // backgroundプロパティではなく、直接Rectangleを定義
    Rectangle {
        id: _baseGradient
        anchors.fill: parent
        color: constants.solidColorGry
        radius: buttonRadius
        gradient: switch(gradientColor) {
                  case "white": buttonGradientWht; break
                  case "goldSm": buttonGradientGldSm; break
                  case "goldLg": buttonGradientGldLg; break
                  case "blue": buttonGradientBlue; break
                  case "blue2": buttonGradientBlue2; break
                  case "red": buttonGradientRed; break
                  case "prev": buttonPrev; break
                  default: buttonGradientWht; break
                  }
        rotation: _mouseArea.pressed ? 180 : 0
        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        onClicked: {
            _gradientButton.clicked()
        }
    }

    states: [
        State {
            name: "selected"
            when: isSelected
            PropertyChanges {
                target: _baseGradient
                gradient: undefined
                color: selectedColor
            }
        }
    ]
}
