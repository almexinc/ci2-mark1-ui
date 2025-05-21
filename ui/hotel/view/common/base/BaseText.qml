import QtQuick
import "../contents"

Text {
    id: _top
    // 言語コードとウェイトの組み合わせで指定するフォントを選択する。
    // 言語コードは
    // ja":日本誤, "cn":中文簡体, "tw":中文繁体, "ko":韓国語, "en":英語, "th":タイ語, "vi":ベトナム語 "id":インドネシア語
    // を想定。
    property string languageCode: constants.languageCode
    // ウェイトは
    // "thin", "extraLight", "light, "regular", "medium", "semiBold", "bold", "extraBold", "black"
    // を想定。
    // Regularのみなので使用しない。
    property string fontWeight: "regular"

    Component.onCompleted: {
        font.family = changeFontFamily(languageCode)
        // console.log(font.family)
    }

    onLanguageCodeChanged: {
        font.family = changeFontFamily(languageCode)
        // console.log(font.family)
    }

    text: font.family

    function changeFontFamily(lang) {
        // 設定言語に応じたfontFamilyを適応する。
        var fontFamily
        switch(lang) {
            case "id":  // インドネシア語
            case "en":  // 英語
            case "ja": fontFamily = constants.fontList.fontJpRegular; break;  //日本語
            case "ko": fontFamily = constants.fontList.fontKoRegular; break;  //韓国語
            case "tw":  // 中文繁体
            case "cn": fontFamily = constants.fontList.fontCnRegular; break;  // 中文簡体
            case "th": fontFamily = constants.fontList.fontThaiRegular; break;    // タイ語
            case "vi": fontFamily = constants.fontList.fontTaiVietRegular; break; // ベトナム語
            default: fontFamily = constants.fontList.fontJpRegular; break;
        }
        return fontFamily.name
    }
}
