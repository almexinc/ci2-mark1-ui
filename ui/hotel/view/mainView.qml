/****************************************************************************
 * @file: mainView.qml
 * @brief: QML処理の初回に読み込まれるQML
 *
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "common/debug"
import "../language.js" as Translations

Window {
    id: _mainview
    width: constants.width
    height: constants.height
    //minimumWidth: width
    //minimumHeight: height
    //maximumWidth: width
    //maximumHeight: height

    visible: true

    property alias constants: _constants

    function pushScreen(qmlFileName) {
        qmlFileName = "qrc:/view/pages/" + qmlFileName + ".qml";

        sharedController.qmlLogInfo("pushScreen: " + qmlFileName );

        let qmlComponent = Qt.createComponent( qmlFileName );

        if ( !qmlComponent ) {
            sharedController.qmlLogError( "画面生成に失敗しました。" );
        } else if ( qmlComponent.errorString() ) {
            sharedController.qmlLogError( qmlComponent.errorString() );
        } else {
            // 現在画面のクリア
            _stackView.clear( StackView.Immediate );
            _stackView.push( qmlComponent, {qmlFileName: qmlFileName}, StackView.Immediate );
        }
    }

    Component.onCompleted: {
        _mainview.pushScreen("SF0-0_InitPage")
    }

    Constants{
        id: _constants
    }

    // 画面コンテンツ
    StackView {
        id: _stackView
        anchors.fill: parent
    }

    // C++側関数からQML処理を呼び出す
    Connections {
        target: sharedController

        function onQmlFilePushScreen(qmlFileName) {
            _mainview.pushScreen(qmlFileName);
        }
    }

    /***画面表示デバック用***/
    Row {
        anchors{
            left: parent.left
            bottom: parent.bottom
        }
        spacing: 5
        DebugButton{
            id: _debugButtonBack
            text: "戻る"
            onClicked: {
                if(_debugView.pageIndex === 0){
                    _debugView.pageIndex = _debugView.pageList.length - 1
                }else{
                    _debugView.pageIndex--
                }
                _debugView.read(_debugView.pageDirectoryName + _debugView.pageList[_debugView.pageIndex])
            }
        }
        DebugButton{
            id: _debugButtonNext
            text: "次へ"
            onClicked: {
                if(_debugView.pageIndex === _debugView.pageList.length - 1){
                    _debugView.pageIndex = 0
                }else{
                    _debugView.pageIndex++
                }
                _debugView.read(_debugView.pageDirectoryName + _debugView.pageList[_debugView.pageIndex])
            }
        }
//        DebugButton{
//            id: _debugLanguage
//            text: "言語：" + language
//            property string language: "ja"
//            onClicked: {
//                switch(language){
//                case "ja":
//                    language = "en"
//                    break
//                default:
//                    language = "ja"
//                }
//            }
//        }
        DebugButton{
            id: _debugViewSize
            text: "画面サイズ：1920✕1080"
            onClicked: {
                constants.width = 1920
                constants.height = 1080
            }
        }
        DebugButton{
            id: _debugViewSize2
            text: "画面サイズ：1280✕1024"
            onClicked: {
                constants.width = 1280
                constants.height = 1024
            }
        }
        DebugButton{
            id: _debugViewSize3
            text: "画面サイズ：1920×720"
            onClicked: {
                constants.width = 1920
                constants.height = 720
            }
        }
    }
    DebugLabel{
        id: _nowPageName
        anchors{
            right: parent.right
            bottom: parent.bottom
        }
    }
    DebugLabel{
        id: _nowViewSize
        text: parent.width + "✕" + parent.height
        anchors{
            right: _nowPageName.left
            rightMargin: 10
            bottom: parent.bottom
        }
    }

    // Width変更イベント
    onWidthChanged: {
        _nowViewSize.text = "Width: " + width + ", Height: " + height;
    }

    // Height変更イベント
    onHeightChanged: {
        _nowViewSize.text = "Width: " + width + ", Height: " + height;
    }

    QtObject{
        id: _debugView
        property var pageList: [ //画面一覧
            "pages/SF2-4_ReservationByNumber.qml",
            "pages/SF2-1_Idle.qml",
            "pages/SF2-2_TermsAndConditions.qml",
            "pages/SF2-3_CheckInSelection.qml",
            "pages/SF2-5_ReservationByName.qml",
            "pages/SF2-6_ReservationByQR.qml",
            "pages/SF2-7_ReservationByPreCard.qml",
            "pages/SF2-8_ReservationByICTag.qml",
            "pages/SF2-11_ReservationByPhone.qml",
        ]
        property int pageIndex: 0 //デバック表示用のページ目次
        property string pageDirectoryName: "./" //ページQML置き場の名前
        Component.onCompleted: {
            // read(pageDirectoryName + pageList[pageIndex]) //初回起動画面読み込み
        }
        /**
         * @brief 画面遷移を実行する
         * @param 画面遷移したいQMLファイル名をセット
         */
        function read(qmlFile) {
            sharedController.qmlLogInfo("create qml: " + qmlFile )
            let qmlComponent = Qt.createComponent(qmlFile)
            if (!qmlComponent) {
                sharedController.qmlLogError("component create failed")
            } else if (qmlComponent.errorString()) {
                sharedController.qmlLogError(qmlComponent.errorString())
            } else {
                _stackView.clear()
                _stackView.push(qmlComponent, StackView.Immediate)

                _nowPageName.text = qmlFile//表示するのQMLファイル名を右下に表示
            }
        }
    }
    //全画面.qmlで呼ぶ翻訳関数の為、Window内直下のスタブ記載箇所に配置
    function qsTrr(str){
        return Translations.qsTr(str, constants.languageCode)
    }
}

