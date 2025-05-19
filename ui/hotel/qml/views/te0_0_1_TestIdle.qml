import QtQuick 6.5
import QtQuick.Controls 6.5

import Almex.Hotel 1.0

Item {
    property string qmlFileName: "te0_0_1_TestIdle"

    StackView.onActivating: console.log("StackView.onActivating:" + qmlFileName)
    StackView.onActivated: console.log("StackView.onActivated:" + qmlFileName)
    StackView.onDeactivating: console.log("StackView.onDeactivating:" + qmlFileName)
    StackView.onDeactivated: console.log("StackView.onDeactivated:" + qmlFileName)
    StackView.onRemoved: {
        console.log("StackView.onRemoved:" + qmlFileName)
        _vm.onRemoved()
    }

    Component.onCompleted: console.log("Component.onCompleted:" + qmlFileName)

    Rectangle {
        color: "red"
        width: 100; height: 100
    }

    TE0_0_1_TestIdle {
        id: _vm
    }
}
