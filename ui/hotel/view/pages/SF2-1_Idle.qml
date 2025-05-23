/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/

import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import "../common/button"
import "../common/contents"
import "../common/background"
import "../common/text"
import "../common/base"

import Almex.Hotel 1.0

Content {
    property string qmlFileName: "" // push時に設定される

    StackView.onRemoved: {
        sharedController.qmlLogInfo("StackView.onRemoved: " + qmlFileName)
        _vm.onRemoved()
    }

    Component.onCompleted: {
        sharedController.qmlLogInfo("Component.onCompleted: " + qmlFileName)
        _vm.init();
    }

    isShowLanguageButton: true

    MainContent {
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

            onButtonClicked: function(condition) {
                _vm.menuButtonClicked(condition)
            }
        }

        MenuButtonGridview {
            id: _optionButtonArea
            width: Window.width > constants.breakPointWidth ? parent.width * 0.82 : parent.width * 0.9
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: _menuButtonArea.bottom
                topMargin: Window.height > constants.breakPointHeight ? 60 : 30
                bottom: parent.bottom
                bottomMargin: Window.height > constants.breakPointHeight ? 60 : 30
            }
            fontPixelSize:30
            menuButtonList: _vm.optionButtonList
        }
    }

    Item {
        id: _virtualHuman
        width: 200
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            bottomMargin: Window.height > constants.breakPointHeight ? constants.largeFooterHeight : constants.smallFooterHeight
            topMargin: Window.height > constants.breakPointHeight ? constants.largeHeaderHeight : constants.smallHeaderHeight
            rightMargin: Window.width > constants.breakPointWidth ? 60 : 20
        }

        Rectangle {
            id: imageWrapper
            width: parent.width
            height: 300
            radius: 20
            clip: true
            layer.enabled: true

            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
                topMargin: Window.height > constants.breakPointHeight ? 180 : 100
            }

            // 画像をRectangleの上に配置
            Item {
                width: 200
                height: 300
                Image {
                    id: srcImage
                    source: "../../img/sample_virtual_human.png"
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    visible: false  // MultiEffectで表示するため非表示
                    layer.enabled: true
                }
                MultiEffect {
                    anchors.fill: parent
                    source: srcImage
                    maskEnabled: true
                    maskSource: maskItem
                }
                Item {  // マスク用アイテム（オフスクリーンレイヤ）
                    id: maskItem
                    anchors.fill: parent
                    layer.enabled: true
                    visible: false
                    Rectangle {
                        anchors.fill: parent
                        radius: 20
                        color: "black"
                        antialiasing: true  // マスク形状はアンチエイリアス不要
                    }
                }
            }

        }

        Rectangle {
            height: 100
            width: parent.width
            anchors {
                top: imageWrapper.bottom
                right: parent.right
                left: parent.left
                topMargin: Window.height > constants.breakPointHeight ? 20 : 30
            }



            GradientButton {
                id: _optionButton
                property int fontPixelSize: 28
                property string languageCode: "ja"
                property bool isClicked: false
                width: 200
                height: parent.height
                gradientColor: "blue"
                buttonRadius: 20



                Rectangle {
                    id:sourceItem
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "#7f888e"
                    border.width: 2
                    radius: 20
                }
                Rectangle {
                    anchors.margins: 1
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "#fff"
                    border.width: 1
                    radius: 20
                }

                DefaultText {
                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                        left: parent.left
                    }
                    text: qsTrr("ヘルプ")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#ffffff"
                    font {
                        bold: true
                        pixelSize: _optionButton.fontPixelSize

                    }
                    languageCode: _optionButton.languageCode
                }

                onClicked: {
                    console.log("ヘルプ押下")
                }
            }
        }


    }

    // stub::
    SF2_1_Idle {
        id: _vm

        property int nowDate: 20241024 //現在日付
        property int nowTime: 1212 //現在時刻
        property string hotelName: "アルメックスホテル浅草" //ホテル名
        property string guidText: qsTrr("ご希望のメニューをタッチしてください") //フッターに表示される案内文

        property var menuButtonList: [ //メニューボタン一覧情報
            { "text": "チェックイン", "columnSpan": 1, "rowSpan": 1, "fontPixelSize": 38, "icon": ""},
            { "text": "チェックアウト", "columnSpan": 1, "rowSpan": 1, "fontPixelSize": 38, "icon": ""},
            { "text": "事前精算", "columnSpan": 1, "rowSpan": 1, "fontPixelSize": 38, "icon": ""},
            { "text": "日帰り入浴", "columnSpan": 1, "rowSpan": 1, "fontPixelSize": 38, "icon": ""}
        ]

        property var optionButtonList: [ //オプションボタン一覧情報
            { "text": "両替", "columnSpan": 1, "rowSpan": 1, "icon": ""},
            { "text": "朝食券", "columnSpan": 1, "rowSpan": 1, "icon": "" },
            { "text": "VOD視聴券", "columnSpan": 1, "rowSpan": 1, "icon": "" },
            { "text": "その他販売", "columnSpan": 1, "rowSpan": 1, "icon": "" }
        ]

        onInitialized: {
            //初期化処理
            _vm.getNowDataTime()
        }

        //初期化処理
        Component.onCompleted: {
            //現在日時の取得
            _vm.getNowDataTime()
        }

        /**
         * FIXME: C++側処理に置き換える
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
