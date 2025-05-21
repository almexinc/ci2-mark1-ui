import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "../contents"
import "../base"
import "../button"

Item {
    id: _buttonGridWrap
    property var optionButtonList: []

    GridLayout {
        id: _buttonGrid
        anchors.fill: parent
        columnSpacing: changeGridSpacing()
        rowSpacing: changeGridSpacing()
        columns: 4
        rows: 1

        Window.onWidthChanged: changeGridSpacing()

        Repeater {
            model: _buttonGridWrap.optionButtonList
            MenuButton {
                property int columnSpan: 1
                property int rowSpan: 1
                buttonText: modelData.text  // modelData.textを使う
                Layout.fillHeight: true
                Layout.preferredWidth: (_buttonGrid.width / _buttonGrid.columns) * columnSpan - (_buttonGrid.rowSpacing * (_buttonGrid.columns - 1) / _buttonGrid.columns)
                Layout.preferredHeight: (_buttonGrid.height / _buttonGrid.rows) * rowSpan - (_buttonGrid.rowSpacing * (_buttonGrid.columns - 1) / _buttonGrid.rows)
                Layout.columnSpan: columnSpan
                Layout.rowSpan: rowSpan
                gradientColor: "white"
                onClicked: {
                    console.log(modelData.text + "押下")
                }
            }

        }
    }

    function changeGridSpacing() {
        _buttonGrid.columnSpacing = Window.width > constants.breakPointWidth ? 60 : 30
        _buttonGrid.rowSpacing = Window.width > constants.breakPointWidth ? 60 : 30
    }
}
