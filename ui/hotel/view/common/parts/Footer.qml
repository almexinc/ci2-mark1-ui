import QtQuick 2.15
import QtQuick.Controls 2.15

import "../text"
import "../button"

Rectangle {
    id: _footer
    property string guidText: ""
    height: Window.height > constants.breakPointHeight ? constants.largeFooterHeight : constants.smallFooterHeight
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    color: "#FFFFFF";

    Item {
        id: _text
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            rightMargin: 300
            leftMargin: 300
        }

        DefaultText {
            width: _footer.width
             anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
             }
            text: _footer.guidText
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }


}

