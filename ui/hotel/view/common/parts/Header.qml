import QtQuick 2.15
import QtQuick.Controls 2.15
import "../button"
import "../text"
import "../base"

Rectangle {
    id: _header
    property int date: 1212
    property int time: 1212
    property string hotelName: ""
    property bool isShowLanguageButton: false
    property bool isShowResetButton: false

    anchors {
        left: parent.left
        right: parent.right
    }
    height: (Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight) ? 100 : constants.largeHeaderHeight

    anchors {
        left: parent.left
        right: parent.right
    }
    color: "#FFF"


    LanguageButtonList {
        visible: isShowLanguageButton
        anchors {
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: (Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight) ? 20 : 0
            left: parent.left
            leftMargin: Window.width > constants.breakPointWidth ? 60 : 20
        }
    }

    Rectangle {
        visible: isShowResetButton
        anchors {
            top: parent.top; topMargin: 20
            left: parent.left; leftMargin: -55
        }
        width: 154
        height: (Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight) ? 80 : 100



        GradientButton {
            id: restButton
            width: 154
            height: parent.height
            gradientColor: "red"
            buttonRadius: 50
            Rectangle {
                anchors.margins: 2
                anchors.fill: parent
                color: "transparent"
                border.color: "#ed6d94"
                border.width: 1
                radius: 50
            }


            onClicked: {
                console.log("初めからやり直す")
            }
        }

        DefaultText {
            anchors {
                top: parent.top
                left: restButton.right; leftMargin:20
                bottom: parent.bottom
            }
            text: qsTrr("初めからやり直す")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font {
                pixelSize: 28

            }
        }


        BaseImage {
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right;rightMargin: 35
            }
            fillMode: Image.PreserveAspectFit
            source: "../../../img/icon/reset.png"
        }


    }

    Item {
        anchors {
            top: parent.top
             right: parent.right
            bottom: parent.bottom
            topMargin: (Window.width < constants.breakPointWidth || Window.height < constants.breakPointHeight) ? 0 : 20
            rightMargin: Window.width > constants.breakPointWidth ? 30 : 20
        }

        NowDateTimeText {
            id: _nowDateTimeText
            anchors {
                right: parent.right
                top: parent.top

            }
            horizontalAlignment: Text.AlignRight
            nowDate: _header.date
            nowTime: _header.time
            languageCode: "ja"
        }


        BaseImage {
            anchors {
                top: _nowDateTimeText.bottom
                bottom: parent.bottom
                right: parent.right
            }
            fillMode: Image.Pad
            source: "../../../img/logo.png"
        }
    }

    // VideoButton {
    //     id: _headerMainButton
    //     width: 240
    //     anchors {
    //         top: parent.top
    //         bottom: parent.bottom
    //         right: parent.right
    //     }
    //     text: qsTrr("ビデオ通話")
    //     fontPixelSize: 35
    //     languageCode: "ja"
    //     onClicked: {
    //         console.log("ビデオ通話押下")
    //     }
    // }
}
