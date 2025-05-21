import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "../contents"
import "../base"
import "../button"

Item {
    id: _buttonGridWrap
    property var menuButtonList: []
    property int fontPixelSize: 0
    property string subText: ""
    property string subFontPixelSize: "38"

    GridLayout {
        id: _buttonGrid
        anchors.fill: parent
        columnSpacing: changeGridSpacing()
        rowSpacing: changeGridSpacing()
        columns:4
        rows: 4

        Window.onWidthChanged: changeGridSpacing()
        Window.onHeightChanged: changeGridSpacing()

        Repeater {
            model: _buttonGridWrap.menuButtonList

            MenuButton {
                property int columnSpan: modelData.columnSpan
                property int rowSpan: modelData.rowSpan
                subText: _buttonGridWrap.subText
                icon: modelData.icon === "" ? "" : modelData.icon
                subFontPixelSize: _buttonGridWrap.subFontPixelSize
                buttonText: modelData.text  // modelData.textを使う
                fontPixelSize: _buttonGridWrap.fontPixelSize === 0 ? modelData.fontPixelSize : _buttonGridWrap.fontPixelSize
                gradientColor: "white"
                Layout.fillHeight: true
                Layout.preferredWidth: (_buttonGrid.width / _buttonGrid.columns) * columnSpan - (_buttonGrid.rowSpacing * (_buttonGrid.columns - 1) / _buttonGrid.columns)
                Layout.preferredHeight: (_buttonGrid.height / _buttonGrid.rows) * rowSpan - (_buttonGrid.rowSpacing * (_buttonGrid.columns - 1) / _buttonGrid.rows)
                Layout.columnSpan: columnSpan
                Layout.rowSpan: rowSpan
                onClicked: {
                    console.log(modelData.text + "押下")
                }
            }
        }
    }

    function changeGridSpacing() {
        _buttonGrid.columnSpacing = Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 15 : 30
        _buttonGrid.rowSpacing = Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 15 : 30
    }
}
