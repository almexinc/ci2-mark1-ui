import QtQuick 2.15
import QtQuick.Controls 2.15

import "../background"
import "../parts"

Rectangle {
    id: _mainContent
    width: Window.width > constants.breakPointWidth ? parent.width - 400 : parent.width - 230
    anchors {
        top: parent.top
        right: parent.rigth
        bottom: parent.bottom
        topMargin: Window.height > constants.breakPointHeight ? constants.largeHeaderHeight : constants.smallHeaderHeight
        rightMargin: 200
        leftMargin: Window.width > constants.breakPointWidth ? 200 : 30
        left:parent.left
        bottomMargin: Window.height > constants.breakPointHeight ? constants.largeFooterHeight : constants.smallFooterHeight
    }

}
