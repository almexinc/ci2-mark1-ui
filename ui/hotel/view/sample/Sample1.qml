/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

import QtQuick
import "../common/button"
import "../common/contents"
import "../common/background"
import "../common/text"
import "../common/base"

Content {
    isShowLanguageButton: true

    Item {
        id: _mainContent
        width: parent.width - _virtualHuman.width
        anchors {
            top: parent.top
            right: parent.rigth
            bottom: parent.bottom
            topMargin: Window.height > constants.breakPointHeight ? constants.largeHeaderHeight : constants.smallHeaderHeight
            rightMargin: _virtualHuman.width
            bottomMargin: Window.height > constants.breakPointHeight ? constants.largeFooterHeight : constants.smallFooterHeight
        }

        TitleText {
            id: _titleText
            anchors {
                top: parent.top
                topMargin: Window.height > constants.breakPointHeight ? 50 : 20
            }
            text: qsTrr("ご希望のメニューを選択してください")
        }

        MenuButtonGridview {
            id: _menuButtonArea
            width: Window.width > constants.breakPointWidth ? parent.width * 0.82 : parent.width * 0.9
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: Window.height > constants.breakPointHeight ? 180 : 100
                bottom: parent.bottom
                bottomMargin: Window.height > constants.breakPointHeight ? 240 : 130
            }
            menuButtonList: _vm.menuButtonList
        }

        OptionButtonGridview {
            id: _optionButtonArea
            width: Window.width > constants.breakPointWidth ? parent.width * 0.82 : parent.width * 0.9
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: _menuButtonArea.bottom
                topMargin: Window.height > constants.breakPointHeight ? 60 : 30
                bottom: parent.bottom
                bottomMargin: Window.height > constants.breakPointHeight ? 60 : 30
            }
            optionButtonList: _vm.optionButtonList
        }
    }

    Item {
        id: _virtualHuman
        width: 240
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            topMargin: 120
            bottomMargin: 120
        }

        BaseImage {
            anchors {
                right: parent.right
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: "../../img/sample_virtual_human.png"
//            source: "/Users/nishida/work/almex/SelfCheckIn_Mark1_development_UI_design/content/img/sample.jpg"
        }
    }

    // stub::
    QtObject {
        id: _vm
        property int nowDate: 20241024 //現在日付
        property int nowTime: 1212 //現在時刻
        property string hotelName: "アルメックスホテル浅草" //ホテル名
        property string guidText: "ご希望のメニューをタッチしてください" //フッターに表示される案内文

        property var menuButtonList: [ //メニューボタン一覧情報
            { "text": "チェックイン", "columnSpan": 1, "rowSpan": 3, "fontPixelSize": 50},
            { "text": "チェックアウト", "columnSpan": 1, "rowSpan": 3, "fontPixelSize": 50},
            { "text": "事前精算", "columnSpan": 1, "rowSpan": 2, "fontPixelSize": 45},
            { "text": "日帰り入浴", "columnSpan": 1, "rowSpan": 1, "fontPixelSize": 35}
        ]

        property var optionButtonList: [ //オプションボタン一覧情報
            { "text": "両替" },
            { "text": "朝食券" },
            { "text": "VOD視聴券" },
            { "text": "その他販売" }
        ]

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
