import QtQuick 2.15
import QtQuick.Controls 2.15

DefaultText {
    id: _titleText
    width: parent.width
    anchors {
//         horizontalCenter: parent.horizontalCenter
        right: parent.right
        left: parent.left
    }
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font {
        pixelSize: 35
        bold: true
    }

    Window.onWidthChanged: changeFontSize()
    Window.onHeightChanged: changeFontSize()

    function changeFontSize() {
        _titleText.font.pixelSize = Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 35 : 50
    }
}
