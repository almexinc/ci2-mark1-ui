/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

import QtQuick
import QtQuick.Controls
import "../common/button"
import "../common/contents"
import "../common/background"
import "../common/text"
import "../common/base"
import "../common/parts"

import Almex.Hotel 1.0

Content {
    property string qmlFileName: "" // push時に設定される

    StackView.onRemoved: {
        sharedController.qmlLogInfo("StackView.onRemoved: " + qmlFileName)
        _vm.onRemoved()
    }

    isShowLanguageButton: false
    isShowResetButton: true
    function updateNextButtonState() {
        const filled = field_num.text.length > 0
        nextButton.enabled = filled
        nextButton.opacity = filled ? 1.0 : 0.25
    }

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
            text: qsTrr("カードを挿入してください")
        }

        Rectangle {
            width: parent.width
            clip: true
            anchors {
                top: _titleText.bottom;topMargin: Window.height > constants.breakPointHeight ? 0 :30
                bottom: parent.bottom
            }

            BaseImage {
                id: _image
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    left: parent.left
                }
                fillMode: Image.PreserveAspectFit
                source: "../../img/sample_image.png"
            }
        }

    }

    PrevButton {
        id: prevButton
        width: 200
        height: 100
        anchors {
            left: parent.left;leftMargin: 30
            bottom: parent.bottom; bottomMargin: 20
        }
        fontPixelSize: 28
        buttonText: qsTrr("戻る")
        onClicked: {
          console.log("戻る押下")
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

        function onRemoved() {
            console.log("onRemoved")
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

    SF2_7_ReservationByPreCard {
        // TODO: stubを解除して使う
        //id: _vm
    }
}
