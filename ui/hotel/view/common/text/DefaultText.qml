import QtQuick 2.15
import QtQuick.Controls 2.15

import "../base"

BaseText {
    color: "#333333"
    text: ""
    font.letterSpacing: 2
    horizontalAlignment: Text.AlignHCenter
    font.pixelSize: 60
    styleColor: "#333333"

    //フォントサイズを表示幅で自動調整する機能
    property int originalFontSize: 0 //最大フォントサイズ
    onOriginalFontSizeChanged: autoFontResize()
    Component.onCompleted: {
        this.originalFontSize = font.pixelSize
        autoFontResize()
    }
    onWidthChanged: autoFontResize()
    onTextChanged: autoFontResize()

    /**
    * @brief フォントサイズ自動調整
    */
    function autoFontResize(){
        font.pixelSize = originalFontSize
        while(width < contentWidth) {
            font.pixelSize -= 2
        }
    }
}
