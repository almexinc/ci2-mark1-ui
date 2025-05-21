import QtQuick 2.15
import QtQuick.Controls 2.15

import "../button"
import "../text"
import "../base"

Popup {
    property string languageCode: "ja"
    property string title: ""
    property string modeDefault: "kana" // "kana|alpha|number" デフォルトでかなキーボード
    property list<string> modeEnable: ["kana","alpha","number"] // 表示するモード配列。デフォルトでは全表示
    property int keyWidth1U: constants.width > constants.breakPointWidth ? 80 : 75
    property int keySpace: (constants.width > constants.breakPointWidth && constants.height > constants.breakPointHeight) ? 20 : 15
    property int keyWidth2U: keyWidth1U * 2 + keySpace * 1
    property int keyWidth3U: keyWidth1U * 3 + keySpace * 2
    property int keyWidth4U: keyWidth1U * 4 + keySpace * 3
    property int keyHeight: constants.height > constants.breakPointHeight ? 70 : 55
    property DefaultTextField targetField: null
    id: _kb
    modal: false
    visible: false
    focus: true
    anchors.centerIn: parent
    closePolicy: Popup.NoAutoClose

    // 背景エリア（画面全体を覆う半透明）
    Rectangle {
        width: Screen.width     // 画面全体の幅
        height: Screen.height   // 画面全体の高さ
        color: "#ffffff"
        opacity: 0.8            // 白80%の透明度に修正
        anchors.centerIn: parent
    }

    Rectangle {
        width: constants.width > constants.breakPointWidth ? 1370 : 1140
        height: constants.height > constants.breakPointHeight ? 800 : 600
        color: "transparent"
        radius: 30
        anchors.centerIn: parent

        // 上部のタイトルバー
        Rectangle {
            width: 320
            height: 100
            color: "#7f888e"
            anchors.top: parent.top
            anchors.topMargin: constants.height > constants.breakPointHeight ? -70 : -50
            anchors.left: parent.left
            anchors.leftMargin: 50
            radius: 20
            DefaultText {
                anchors.fill: parent
                anchors.bottomMargin: constants.height > constants.breakPointHeight ? 30 : 50
                text: _kb.title
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                font {
                    bold: true
                    pixelSize: 35
                }
            }
        }

        // ポップアップの灰色の地
        Rectangle {
            width: parent.width
            height: parent.height
            color: "#d9d9d9"
            border.color: "#7f888e"
            radius: 30
            anchors.centerIn: parent

            // 閉じるボタン
            KeyBoardButton {
                buttonText: "× とじる"
                width: 150
                fontPixelSize: 25
                height: _kb.keyHeight
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: - (constants.width > constants.breakPointWidth ? 75 : 50)
                anchors.topMargin: 20
                gradientColor: "prev"
                textColor: "#ffffff"
                onClicked: {
                    // keyboardInputテキストフィールドを空にして閉じる
                    keyboardInput.text = ""
                    _kb.visible = false
                    keyboardInput.forceActiveFocus(Qt.ShortcutFocusReason);
                }
            }

            Column {
                spacing: 10
                width: parent.width - (constants.width > constants.breakPointWidth ? 200 : 80)
                height: parent.height - (constants.height > constants.breakPointHeight ? 120 : 60)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                // キーボードの入力エリア
                Rectangle {
                    id: keyboardInputContainer
                    width: parent.width - (constants.width > constants.breakPointWidth ? 0 : 100)
                    height: constants.height > constants.breakPointHeight ? 70 : 60
                    color: "transparent"
                    DefaultTextField {
                        id: keyboardInput
                        width: parent.width
                        height: parent.height
                        anchors.fill: parent
                        font.pixelSize: constants.height > constants.breakPointHeight ? 40 : 30
                        gradientColor: keyboardInput.gradientWht
                    }
                    Rectangle {
                        anchors.right: parent.right
                        color: "transparent"
                        width: 90
                        height: parent.height
                        DefaultText {
                            anchors.fill: parent
                            text: "×"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: "#333333"
                            font {
                                bold: true
                                pixelSize: 30
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                keyboardInput.text = ""
                            }
                        }
                    }
                }

                // キーボードのmodeボタンエリア
                Row {
                    topPadding: constants.height > constants.breakPointHeight ? 90 : 70
                    spacing: _kb.keySpace * 1.5
                    // 左側のキーボード種別切り替えボタン
                    Column {
                        width: _kb.keyWidth1U * 2
                        spacing: _kb.keySpace
                        anchors.margins: 10
                        KeyBoardButton {
                            buttonText: "あいう"
                            width: parent.width
                            height: _kb.keyHeight
                            fontPixelSize: 30
                            isSelected: _kb.modeDefault === "kana"
                            visible: _kb.languageCode === "ja" && _kb.modeEnable.indexOf("kana") !== -1
                            onClicked: {
                                _kb.modeDefault = "kana"
                            }
                        }
                        KeyBoardButton {
                            buttonText: "英数"
                            width: parent.width
                            height: _kb.keyHeight
                            fontPixelSize: 30
                            isSelected: _kb.modeDefault === "alpha"
                            visible: _kb.modeEnable.indexOf("alpha") !== -1
                            onClicked: {
                                _kb.modeDefault = "alpha"
                            }
                        }
                        KeyBoardButton {
                            buttonText: "数字"
                            width: parent.width
                            height: _kb.keyHeight
                            fontPixelSize: 30
                            isSelected: _kb.modeDefault === "number"
                            visible: _kb.modeEnable.indexOf("number") !== -1
                            onClicked: {
                                _kb.modeDefault = "number"
                            }
                        }
                    }

                    // カナキーボード
                    Column {
                        spacing: _kb.keySpace
                        anchors.margins: 10
                        visible: _kb.modeDefault === "kana"
                        Grid {
                            id: keyGridKana
                            columns: 10
                            spacing: _kb.keySpace
                            width: parent.width
                            Repeater {
                                model: [
                                    "あ","か","さ","た","な","は","ま","や","ら","わ",
                                    "い","き","し","ち","に","ひ","み","ゆ","り","を",
                                    "う","く","す","つ","ぬ","ふ","む","よ","る","ん",
                                    "え","け","せ","て","ね","へ","め","、。","れ",
                                ]

                                KeyBoardButton {
                                    buttonText: modelData       // モデルから取得した文字を設定
                                    width: _kb.keyWidth1U
                                    height: _kb.keyHeight
                                    fontPixelSize: 30
                                    onClicked: insertChar(buttonText)
                                }
                            }
                            KeyBoardButton {
                                buttonText: "゛゜"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 30
                                property string dakutenMode: "normal" // nomarl|dakuten|handakuten
                                onClicked: {
                                    // キーボードの文字を濁点付きに変える
                                    let button;
                                    switch (dakutenMode) {
                                        case "normal":
                                            // 濁点モードに変更
                                            dakutenMode = "dakuten";
                                            let seionToDakuon = {
                                                "か": "が", "き": "ぎ", "く": "ぐ", "け": "げ", "こ": "ご",
                                                "さ": "ざ", "し": "じ", "す": "ず", "せ": "ぜ", "そ": "ぞ",
                                                "た": "だ", "ち": "ぢ", "つ": "づ", "て": "で", "と": "ど",
                                                "は": "ば", "ひ": "び", "ふ": "ぶ", "へ": "べ", "ほ": "ぼ",
                                                "う": "ゔ",
                                                "カ": "ガ", "キ": "ギ", "ク": "グ", "ケ": "ゲ", "コ": "ゴ",
                                                "サ": "ザ", "シ": "ジ", "ス": "ズ", "セ": "ゼ", "ソ": "ゾ",
                                                "タ": "ダ", "チ": "ヂ", "ツ": "ヅ", "テ": "デ", "ト": "ド",
                                                "ハ": "バ", "ヒ": "ビ", "フ": "ブ", "ヘ": "ベ", "ホ": "ボ",
                                                "ウ": "ヴ", 
                                            };
                                            for (let i = 0; i < keyGridKana.children.length; i++) {
                                                button = keyGridKana.children[i];
                                                if (button.buttonText) {
                                                    if (seionToDakuon[button.buttonText]) {
                                                        button.buttonText = seionToDakuon[button.buttonText];
                                                    }
                                                }
                                            }
                                            break;
                                        case "dakuten":
                                            // 半濁点モードに変更
                                            dakutenMode = "handakuten";
                                            let dakuonToHandakuon = {
                                                "が": "か", "ぎ": "き", "ぐ": "く", "げ": "け", "ご": "こ",
                                                "ざ": "さ", "じ": "し", "ず": "す", "ぜ": "せ", "ぞ": "そ",
                                                "だ": "た", "ぢ": "ち", "づ": "つ", "で": "て", "ど": "と",
                                                "ば": "ぱ", "び": "ぴ", "ぶ": "ぷ", "べ": "ぺ", "ぼ": "ぽ",
                                                "ゔ": "う",
                                                "ガ": "カ", "ギ": "キ", "グ": "ク", "ゲ": "ケ", "ゴ": "コ",
                                                "ザ": "サ", "ジ": "シ", "ズ": "ス", "ゼ": "セ", "ゾ": "ソ",
                                                "ダ": "タ", "ヂ": "チ", "ヅ": "ツ", "デ": "テ", "ド": "ト",
                                                "バ": "パ", "ビ": "ピ", "ブ": "プ", "ベ": "ペ", "ボ": "ポ",
                                                "ヴ": "ウ",
                                            };
                                            for (let i = 0; i < keyGridKana.children.length; i++) {
                                                button = keyGridKana.children[i];
                                                if (button.buttonText) {
                                                    if (dakuonToHandakuon[button.buttonText]) {
                                                        button.buttonText = dakuonToHandakuon[button.buttonText];
                                                    }
                                                }
                                            }
                                            break;
                                        case "handakuten":
                                            // 通常モードに戻す
                                            dakutenMode = "normal";
                                            // 半濁音を静音に戻す
                                            let handakuonToSeion = {
                                                "ぱ": "は", "ぴ": "ひ", "ぷ": "ふ", "ぺ": "へ", "ぽ": "ほ",
                                                "パ": "ハ", "ピ": "ヒ", "プ": "フ", "ペ": "ヘ", "ポ": "ホ",
                                            };
                                            for (let i = 0; i < keyGridKana.children.length; i++) {
                                                button = keyGridKana.children[i];
                                                if (button.buttonText) {
                                                    if (handakuonToSeion[button.buttonText]) {
                                                        button.buttonText = handakuonToSeion[button.buttonText];
                                                    }
                                                }
                                            }
                                            break;
                                    }
                                }
                            }
                            Repeater {
                                model: [
                                    "お","こ","そ","と","の","ほ","も","ー","ろ",
                                ]
                                KeyBoardButton {
                                    buttonText: modelData       // モデルから取得した文字を設定
                                    width: _kb.keyWidth1U
                                    height: _kb.keyHeight
                                    fontPixelSize: 30
                                    onClicked: insertChar(buttonText)
                                }
                            }
                            KeyBoardButton {
                                buttonText: "小"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 30
                                property bool isYouon: false;
                                onClicked: {
                                    // キーボードの文字を拗音に変える
                                    isYouon = !isYouon;
                                    if (isYouon) {
                                        buttonText = "大";
                                        let youonMap = {
                                            "あ": "ぁ", "い": "ぃ", "う": "ぅ", "ゔ": "ぅ", "え": "ぇ", "お": "ぉ",
                                            "や": "ゃ", "ゆ": "ゅ", "よ": "ょ", "つ": "っ",
                                            "カ": "ヵ", "ケ": "ヶ", // カタカナも対応
                                            "ア": "ァ", "イ": "ィ", "ウ": "ゥ", "ヴ": "ゥ", "エ": "ェ", "オ": "ォ",
                                            "ヤ": "ャ", "ユ": "ュ", "ヨ": "ョ", "ツ": "ッ"
                                        };
                                        // 拗音に変換
                                        for (let i = 0; i < keyGridKana.children.length; i++) {
                                            let button = keyGridKana.children[i];
                                            if (button.buttonText) {
                                                // ひらがな拗音変換表
                                                if (youonMap[button.buttonText]) {
                                                    button.buttonText = youonMap[button.buttonText];
                                                }
                                            }
                                        }
                                    } else {
                                        buttonText = "小";
                                        let youonMap = {
                                            "ぁ": "あ", "ぃ": "い", "ぅ": "う", "ぇ": "え", "ぉ": "お",
                                            "ゃ": "や", "ゅ": "ゆ", "ょ": "よ", "っ": "つ",
                                            "ヵ": "カ", "ヶ": "ケ", // カタカナも対応
                                            "ァ": "ア", "ィ": "イ", "ゥ": "ウ", "ェ": "エ", "ォ": "オ",
                                            "ャ": "ヤ", "ュ": "ユ", "ョ": "ヨ", "ッ": "ツ"
                                        };
                                        // 通常に戻す
                                        for (let i = 0; i < keyGridKana.children.length; i++) {
                                            let button = keyGridKana.children[i];
                                            if (button.buttonText) {
                                                // ひらがな拗音変換表
                                                if (youonMap[button.buttonText]) {
                                                    button.buttonText = youonMap[button.buttonText];
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Row {
                            spacing: _kb.keySpace
                            KeyBoardButton {
                                buttonText: "◀"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("left")
                            }
                            KeyBoardButton {
                                buttonText: "▶"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("right")
                            }
                            KeyBoardButton {
                                buttonText: "かな"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 25
                                property bool isKatakana: false;
                                onClicked: {
                                    // ひらがなカタカナモード変更
                                    isKatakana = !isKatakana;
                                    if (!isKatakana) {
                                        buttonText = "カナ";
                                    } else {
                                        buttonText = "かな";
                                    }

                                    // keyGridKanaの文字を全て大文字小文字切り替え
                                    for (let i = 0; i < keyGridKana.children.length; i++) {
                                        let button = keyGridKana.children[i];
                                        if (button.buttonText) {
                                            if (isKatakana) {
                                                // カタカナに変換
                                                button.buttonText = button.buttonText.replace(/[\u3041-\u3096]/g, function(ch) {
                                                    return String.fromCharCode(ch.charCodeAt(0) + 0x60);
                                                });
                                            } else {
                                                // ひらがなに変換
                                                button.buttonText = button.buttonText.replace(/[\u30a1-\u30f6]/g, function(ch) {
                                                    return String.fromCharCode(ch.charCodeAt(0) - 0x60);
                                                });
                                            }
                                        }
                                    }
                                }
                            }
                            KeyBoardButton {
                                buttonText: "スペース"
                                width: _kb.keyWidth3U
                                height: _kb.keyHeight
                                onClicked: insertChar(" ")
                            }
                            KeyBoardButton {
                                buttonText: "消去"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "prev"
                                textColor: "#ffffff"
                                labelLeftMargin: 60
                                labelRightMargin: 20

                                BaseImage {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.verticalCenter: parent.verticalCenter
                                    fillMode: Image.PreserveAspectFit
                                    source: "../../../img/icon/arrow_backspace.png"
                                }
                                onClicked: _kb.deleteCharBeforeCursor()
                            }
                            KeyBoardButton {
                                buttonText: "確定"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "blue2"
                                textColor: "#ffffff"
                                onClicked: {
                                    _kb.close()
                                }
                            }
                        }
                    }

                    // アルファベットキーボード
                    Column {
                        spacing: _kb.keySpace
                        anchors.margins: 10
                        visible: _kb.modeDefault === "alpha"
                        Grid {
                            id: keyGridAlpha
                            columns: 10
                            spacing: _kb.keySpace
                            width: parent.width
                            Repeater {
                                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                                    "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                                    "a", "s", "d", "f", "g", "h", "j", "k", "l", "!",
                                    "z", "x", "c", "v", "b", "n", "m", ";", ":", "?",
                                    "(", ")", "&", "_", "/", ", ", ".", "‘", "@", "-"]

                                KeyBoardButton {
                                    buttonText: modelData       // モデルから取得した文字を設定
                                    width: _kb.keyWidth1U
                                    height: _kb.keyHeight
                                    fontPixelSize: 30
                                    onClicked: insertChar(buttonText)
                                }
                            }
                        }
                        Row {
                            spacing: _kb.keySpace
                            KeyBoardButton {
                                buttonText: "◀"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("left")
                            }
                            KeyBoardButton {
                                buttonText: "▶"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("right")
                            }
                            KeyBoardButton {
                                buttonText: "ABC"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 25
                                property bool isUpperCase: false;
                                onClicked: {
                                    // 大文字小文字モード変更
                                    isUpperCase = !isUpperCase;
                                    if (!isUpperCase) {
                                        buttonText = buttonText.toUpperCase();
                                    } else {
                                        buttonText = buttonText.toLowerCase();
                                    }

                                    // keyGridAlphaの文字を全て大文字小文字切り替え
                                    for (let i = 0; i < keyGridAlpha.children.length; i++) {
                                        let button = keyGridAlpha.children[i];
                                        if (button.buttonText) {
                                            if (isUpperCase) {
                                                button.buttonText = button.buttonText.toUpperCase();
                                            } else {
                                                button.buttonText = button.buttonText.toLowerCase();
                                            }
                                        }
                                    }
                                }
                            }
                            KeyBoardButton {
                                buttonText: "スペース"
                                width: _kb.keyWidth3U
                                height: _kb.keyHeight
                                onClicked: insertChar(" ")
                            }
                            KeyBoardButton {
                                buttonText: "消去"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "prev"
                                textColor: "#ffffff"
                                labelLeftMargin: 60
                                labelRightMargin: 20

                                BaseImage {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.verticalCenter: parent.verticalCenter
                                    fillMode: Image.PreserveAspectFit
                                    source: "../../../img/icon/arrow_backspace.png"
                                }
                                onClicked: _kb.deleteCharBeforeCursor()
                            }
                            KeyBoardButton {
                                buttonText: "確定"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "blue2"
                                textColor: "#ffffff"
                                onClicked: {
                                    _kb.close()
                                }
                            }
                        }
                    }

                    // 数字キーボード
                    Column {
                        spacing: _kb.keySpace
                        anchors.margins: 10
                        visible: _kb.modeDefault === "number"
                        Grid {
                            // 列は真ん中寄せ
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: _kb.keyWidth2U + _kb.keySpace
                            anchors.rightMargin: _kb.keyWidth2U + _kb.keySpace

                            id: keyGrid
                            columns: 3
                            spacing: _kb.keySpace
                            width: parent.width
                            Repeater {
                                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                                KeyBoardButton {
                                    buttonText: modelData
                                    width: _kb.keyWidth2U
                                    height: _kb.keyHeight
                                    fontPixelSize: 30
                                    onClicked: insertChar(buttonText)
                                }
                            }
                            Rectangle {
                                width: _kb.keyWidth2U
                                height: _kb.keyHeight
                                color: "transparent"
                            }
                            Repeater {
                                model: ["0", "-"]
                                KeyBoardButton {
                                    buttonText: modelData
                                    width: _kb.keyWidth2U
                                    height: _kb.keyHeight
                                    fontPixelSize: 30
                                    onClicked: insertChar(buttonText)
                                }
                            }
                            Rectangle {
                                width: _kb.keyWidth2U
                                height: _kb.keyHeight
                                color: "transparent"
                            }
                        }
                        Row {
                            spacing: _kb.keySpace
                            KeyBoardButton {
                                buttonText: "◀"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("left")
                            }
                            KeyBoardButton {
                                buttonText: "▶"
                                width: _kb.keyWidth1U
                                height: _kb.keyHeight
                                fontPixelSize: 15
                                onClicked: cursorMove("right")
                            }

                            Rectangle {
                                width: _kb.keyWidth4U
                                height: _kb.keyHeight
                                color: "transparent"
                            }

                            KeyBoardButton {
                                buttonText: "消去"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "prev"
                                textColor: "#ffffff"
                                labelLeftMargin: 60
                                labelRightMargin: 20

                                BaseImage {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.verticalCenter: parent.verticalCenter
                                    fillMode: Image.PreserveAspectFit
                                    source: "../../../img/icon/arrow_backspace.png"
                                }
                                onClicked: _kb.deleteCharBeforeCursor()
                            }
                            KeyBoardButton {
                                buttonText: "確定"
                                width: _kb.keyWidth2U
                                fontPixelSize: 30
                                height: _kb.keyHeight
                                gradientColor: "blue2"
                                textColor: "#ffffff"
                                onClicked: {
                                    _kb.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    function deleteCharBeforeCursor() {
        let pos = keyboardInput.cursorPosition;
        if (pos > 0) {
            keyboardInput.text = keyboardInput.text.slice(0, pos - 1) + keyboardInput.text.slice(pos);
            keyboardInput.cursorPosition = pos - 1;
            keyboardInput.forceActiveFocus(Qt.ShortcutFocusReason);
        }
    }
    function insertChar(str) {
        let pos = keyboardInput.cursorPosition;
        keyboardInput.text = keyboardInput.text.slice(0, pos) + str + keyboardInput.text.slice(pos);
        keyboardInput.cursorPosition = pos + str.length;
        keyboardInput.forceActiveFocus(Qt.ShortcutFocusReason);
    }
    function cursorMove(dir) {
        keyboardInput.forceActiveFocus(Qt.ShortcutFocusReason);
        if (dir === "left") {
            keyboardInput.cursorPosition -= 1 // カーソルを左に移動
            if (keyboardInput.cursorPosition < 0)
            {
                keyboardInput.cursorPosition = 0 // カーソル位置を0に制限
            }
        }
        else if (dir === "right") {
            keyboardInput.cursorPosition += 1 // カーソルを右に移動
            if (keyboardInput.cursorPosition > keyboardInput.text.length)
            {
                keyboardInput.cursorPosition = keyboardInput.text.length // カーソル位置をテキストの長さに制限
            }
        }
    }
    function open(targetField) {
        keyboardPopup.targetField = targetField
        keyboardInput.text = keyboardPopup.targetField.text
        keyboardPopup.visible = true
    }
    function close() {
        keyboardPopup.targetField.text = keyboardInput.text
        keyboardPopup.visible = false
    }
}

