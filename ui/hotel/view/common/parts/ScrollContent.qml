import QtQuick
import QtQuick.Controls 2.15
import "../button"
import "../text"
import "../base"

Rectangle {
    id: _ScrollContent
    property string mainText: ""
    property string contentText: ""
    property int contentHeight: 488
    width: parent.width
    height: _ScrollContent.contentHeight

    Rectangle {
        border.color: "#c4c4c4"
        border.width: 1
        width: parent.width
        height: _ScrollContent.contentHeight


        Flickable {
            id: flickArea
            width: parent.width
            height: parent.height
            contentWidth: parent.width
            contentHeight: contentColumn.height + 120
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            onContentYChanged: {
                upArrow.visible = contentY > 0
                downArrow.visible = contentY < contentHeight - height
                scrollUp.opacity = contentY > 0 ? 1 : 0.25
                scrollUp.enabled = contentY > 0
                scrollDown.opacity = contentY < contentHeight - height ? 1 : 0.25
                scrollDown.enabled = contentY < contentHeight - height
            }

            Column {
                id: contentColumn
                width: parent.width - 160
                spacing: Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 10 : 28
                anchors {
                    top: parent.top;topMargin: 60
                    right: parent.right;rightMargin: 80
                    left: parent.left;leftMargin: 80
                    bottomMargin: 40
                }


                BaseText {
                    text: _ScrollContent.mainText
                    font.pixelSize: Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 24 : 28
                }

                BaseText {
                    width: parent.width
                    wrapMode: Text.Wrap
                    font.pixelSize: Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight ? 24 : 28
                    text: _ScrollContent.contentText
                }
            }
        }

        // 中央の上下矢印（非表示制御付き）
        BaseImage {
            id: upArrow
            source: "../../../img/icon/scroll_arrow.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top;topMargin: -30
            }
            visible: flickArea.contentY > 0
            MouseArea {
                anchors.fill: parent
                onClicked: flickArea.contentY -= 100
            }
        }

        BaseImage {
            id: downArrow
            source: "../../../img/icon/scroll_arrow.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom; bottomMargin: -30
            }
            rotation: 180
            visible: flickArea.contentY < flickArea.contentHeight - flickArea.height
            MouseArea {
                anchors.fill: parent
                onClicked: flickArea.contentY += 100
            }
        }
    }

    // ===========================
    // 上のスクロールボタン（外側に配置）
    // ===========================
    BaseImage {
        id: scrollUp
        source: "../../../img/scroll_button_top.png"
        width: 70
        height: 70
        anchors {
            top: parent.top
            right: parent.right;rightMargin: -100
        }

        opacity: flickArea.contentY > 0 ? 1 : 0.25
        MouseArea {
            anchors.fill: parent
            enabled: parent.opacity > 0.99
            onClicked: flickArea.contentY -= 100
        }
    }

    // ===========================
    // 下のスクロールボタン（外側に配置）
    // ===========================
    BaseImage {
        id: scrollDown
        source: "../../../img/scroll_button_bottom.png"
        width: 70
        height: 70
        anchors {
            bottom: parent.bottom
            right: parent.right;rightMargin: -100
        }

        opacity: flickArea.contentY < flickArea.contentHeight - flickArea.height ? 1 : 0.25
        MouseArea {
            anchors.fill: parent
            enabled: parent.opacity > 0.99
            onClicked: flickArea.contentY += 100
        }
    }

    // ===========================
    // スクロールトラック
    // ===========================
    Rectangle {
        id: scrollTrack
        width: 10
        radius: 5
        color: "#c9921e"
        anchors {
            top: scrollUp.bottom;topMargin: 15
            bottom: scrollDown.top;bottomMargin: 15
            right: scrollUp.right;rightMargin: 30
        }

    }


    Rectangle {
        width: 50
        color: "transparent"
        anchors {
            top: scrollUp.bottom;topMargin: 15
            bottom: scrollDown.top;bottomMargin: 15
            right: scrollUp.right;rightMargin: 10
        }
        Rectangle {
            id: scrollHandle
            width: 50
            height: 100
            radius: 5
            color: "transparent"
            border.color: "transparent"


            Image {
                source: "../../../img/scroll.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }

            y: (flickArea.contentY / (flickArea.contentHeight - flickArea.height)) * (scrollTrack.height - height)

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: scrollHandle
                drag.axis: Drag.YAxis
                drag.minimumY: 0
                drag.maximumY: scrollTrack.height - scrollHandle.height
                onPositionChanged: {
                    const ratio = scrollHandle.y / (scrollTrack.height - scrollHandle.height)
                    flickArea.contentY = ratio * (flickArea.contentHeight - flickArea.height)
                }
            }
        }

    }


}
