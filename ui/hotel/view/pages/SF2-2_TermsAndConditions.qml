/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

import QtQuick
import QtQuick.Controls 2.15
import "../common/button"
import "../common/contents"
import "../common/background"
import "../common/text"
import "../common/base"
import "../common/parts"

Content {
    isShowLanguageButton: false
    isShowResetButton: true

    Rectangle {
        width: parent.width
        anchors {
            top: parent.top;topMargin: Window.height > constants.breakPointHeight ? constants.largeHeaderHeight : constants.smallHeaderHeight
            right: parent.rigth
        }
        ProgressCircle {
            percentage: 40
            centerText: qsTrr("取引\n完了まで")
        }
    }



    MainContent {
        TitleText {
            id: _titleText
            anchors {
                top: parent.top
                topMargin: Window.height > constants.breakPointHeight ? 50 : 20
            }
            text: qsTrr("宿泊約款及び宿泊に関する注意事項")
        }

        Rectangle {
            width: parent.width
            height: parent.height
            clip: true
            anchors {
                top: _titleText.bottom;topMargin: Window.height > constants.breakPointHeight ? 40 : 20
            }

            Rectangle {
                id:_kiyakuContent
                width: Window.width > constants.breakPointWidth ? parent.width - 230 : parent.width - 200
                height: Window.height > constants.breakPointHeight ? 548 : 400
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top;topMargin:30
                }

                ScrollContent {
                    mainText: qsTrr("宿泊約款")
                    contentText: "テキストサンプル".repeat(200)
                    contentHeight: Window.height > constants.breakPointHeight ? 488 :360
                }
            }

            Row {
                id:buttonRow
                anchors {
                    top: _kiyakuContent.bottom;topMargin:0
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 25
                CancelButton {
                    width:320
                    height:100
                    anchors {
                        top: parent.top;
                    }
                    buttonText:qsTrr("同意しません")

                    onClicked: {
                        console.log("同意しない押下 ")
                    }
                }
                ConfirmButton {
                    width:320
                    height:100
                    anchors {
                        top: parent.top;
                    }
                    buttonText:qsTrr("同意する")

                    onClicked: {
                        console.log("同意する押下 ")
                    }
                }

            }
        }


    }



    // stub::
    QtObject {
        id: _vm
        property int nowDate: 20241024 //現在日付
        property int nowTime: 1212 //現在時刻
        property string hotelName: "アルメックスホテル浅草" //ホテル名
        property string guidText: "" //フッターに表示される案内文



        //初期化処理
        Component.onCompleted: {
            //現在日時の取得
            _vm.getNowDataTime()
        }

        /**
         * @brief （スタブ内だけの利用）現在日時を取得
        */
        function getNowDataTime() {
            var date = new Date();
            var japanTime = new Date(date.getTime() + (9 * 60 * 60 * 1000)); // 日本時間

            var year = japanTime.getUTCFullYear(); // 年を取得
            var month = ("0" + (japanTime.getUTCMonth() + 1)).slice(-2); // 月を2桁で取得
            var day = ("0" + japanTime.getUTCDate()).slice(-2); // 日付を2桁で取得

            _vm.nowDate = parseInt(year + month + day, 10); // 結合して数値に変換

            var hour = ("0" + japanTime.getUTCHours()).slice(-2); // 時間を2桁で取得
            var minute = ("0" + japanTime.getUTCMinutes()).slice(-2); // 分を2桁で取得

            _vm.nowTime = parseInt(hour + minute, 10); // 結合して数値に変換
        }
    }
    // （スタブ内だけの利用）現在時刻の更新用のタイマー
    Timer {
        interval: 1000//リアルタイムで現在時刻を更新をする
        repeat: true; running: true
        onTriggered: {
            _vm.getNowDataTime()
        }
    }
}
