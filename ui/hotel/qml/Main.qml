/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
import QtQuick 6.5
import QtQuick.Window 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Window {
    id: _root

    // window横幅
    readonly property real _window_width: 1920
    // window高さ
    readonly property real _window_height: 1080

    width: _window_width * _wsc.xScale
    height: _window_height * _wsc.yScale
    visible: true
    minimumWidth: width
    minimumHeight: height
    flags: Qt.Window | Qt.WindowSystemMenuHint

    // qmlFileName: /qml/views/の下にあるファイル名を指定する。
    function pushScreen(qmlFileName) {
        // 現在画面のクリア
        _stackView.clear( StackView.Immediate );

        qmlFileName = "qrc:/qml/views/" + qmlFileName + ".qml";

        console.log( "pushScreen: " + qmlFileName );

        let qmlComponent = Qt.createComponent( qmlFileName );

        if ( !qmlComponent ) {
            console.log( "component create failed" );
        } else if ( qmlComponent.errorString() ) {
            console.log( qmlComponent.errorString() );
        }

        _stackView.push( qmlComponent, StackView.Immediate );
    }

    Component.onCompleted: {
        _root.x = 0
        _root.y = 0

        _root.pushScreen("m0_0_0_InitPage")
    }

    QtObject {
        id: _wsc

        // 全体のスケール設定
        property real xScale: 0.8 // 1.0
        property real yScale: 0.8 // 1.0
    }

    // メインの表示領域
    Item {
        width: _window_width
        height: _window_height
        focus: true

        // デバッグ用の画面サイズ変更用transform
        transform: Scale {
            xScale: _wsc.xScale
            yScale: _wsc.yScale
        }

        // 画面コンテンツ
        StackView {
            id: _stackView
            anchors.fill: parent
        }
    }


    // C++側関数からQML処理を呼び出す
    Connections {
        target: sharedController

        function onQmlFilePushScreen(qmlFileName) {
            _root.pushScreen(qmlFileName);
        }
    }
}
