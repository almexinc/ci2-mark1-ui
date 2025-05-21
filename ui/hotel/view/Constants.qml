import QtQuick

QtObject {
//    1920×1080
//    1280✕1024
//    1920×720

    property int width: 1920
//  property int width: 1280
//  property int width: 720

    property int height: 1080
//  property int height: 1024
//  property int height: 720

    // ブレイクポイント
    property int breakPointWidth: 1500
    property int breakPointHeight: 1000

    // ヘッダー、フッターの高さ
    property int largeHeaderHeight: 120
    property int largeFooterHeight: 120
    property int smallHeaderHeight: 80
    property int smallFooterHeight: 80

    // 言語設定
    property string languageCode: "ja"

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#c2c2c2"

    property var gradientColorWht: ["#FFFFFF", "#D2D2D2", "#A4A4A4"]   // グラデーション（白）。
    property var gradientColorGldSm: ["#b48839", "#d9b156", "#b18f37"]              // グラデーション（ゴールド）（小）。
    property var gradientColorGldLg: ["#AB831A", "#D9A93C", "#D7A73B", "#B47F20"]   // グデーション（ゴールド）（大）。
    property var gradientColorBlue: ["#20a5cb", "#007da1", "#007da1", "#006a88"]   // グラデーション（青）。
    property var gradientColorBlue2: ["#63a0f3", "#0967e7", "#096cf2", "#0549a5"]   // グラデーション（青2）。
    property var gradientColorRed: ["#ad0036", "#e60e50", "#e40d50", "#ee80a2"]   // グラデーション（赤）。
    property var gradientColorPrev: ["#2e2e3f", "#585867", "#585867", "#8d8d9e"]   // グラデーション（前）。

//    property string solidColorRed: "#dd2c46"    // ボタン色（赤）。
    property string solidColorRed: "#C4123C"    // ボタン色（赤）
    property string solidColorblu: "#1891DB"  // ボタン色（青）。
    property string solidColorGry: "#888d94"    // ボタン色（グレー）。
    property string solidColorDkGry: "#585867"  // ボタン色（ダークグレー）。

    property string textColor: "#333333"
    property string textContrastColor: "#FFFFFF"

    // 言語別フォント設定
    property QtObject fontList: QtObject {
        id: _fonts
        // 日本語/英語/インドネシア語
        property FontLoader fontJpRegular: FontLoader {
            source: "../fonts/NotoSansJP-Regular.ttf"
        }

        // 韓国語
        property FontLoader fontKoRegular: FontLoader {
            source: "../fonts/NotoSansKR-Regular.ttf"
        }

        // 中文
        property FontLoader fontCnRegular: FontLoader {
            source: "../fonts/NotoSansSC-Regular.ttf"
        }

        // タイ語
        property FontLoader fontThaiRegular: FontLoader {
            source: "../fonts/NotoSansThai-Regular.ttf"
        }

        // ベトナム語
        property FontLoader fontTaiVietRegular: FontLoader {
            source: "../fonts/NotoSansTaiViet-Regular.ttf"
        }
    }

    // 言語設定ボタンのリスト
    property var languageButtonList: [
        { languageCode: "ja", text: "日本語" },
        { languageCode: "en", text: "English" },
        { languageCode: "cn", text: "簡体中文" },
        { languageCode: "tw", text: "繁体中文" },
        { languageCode: "ko", text: "한국어" },
        { languageCode: "th", text: "แบบไทย" },
        { languageCode: "id", text: "bahasa\nIndonesia" },
        { languageCode: "vi", text: "Tiếng Việt" }
    ]

}
