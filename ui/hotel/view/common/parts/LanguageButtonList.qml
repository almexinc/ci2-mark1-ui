import QtQuick 2.15
import QtQuick.Controls 2.15

import "../button"
import "../text"

Row {
    spacing: 10
    property int selectedIndex: 0  // 選択されたボタンのインデックスを管理

    Repeater {
        model: constants.languageButtonList

        delegate: LanguageButton {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: Window.width > constants.breakPointWidth ? 150 : 100



            buttonText: modelData.text

            // 選択状態を反映
            isSelected: selectedIndex === index

            onClicked: {
                selectedIndex = index  // 選択されたボタンのインデックスを更新
                constants.languageCode = modelData.languageCode

                console.log(modelData.languageCode + "押下")
                sharedController.changeLanguageCodeForQml(modelData.languageCode)
            }
        }
    }
}
