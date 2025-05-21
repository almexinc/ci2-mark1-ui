import QtQuick
import QtQuick.Controls

ScrollBar {
    id: _scrollbar
    property var scrollTarget
    width: 8
    orientation: Qt.Vertical
    policy: ScrollBar.AlwaysOn
    interactive: true
    contentItem: Rectangle {
        implicitWidth: 8
        radius: 3
        color: "#333"
    }

    // size はバインディングOK（読み取り専用）
    size: scrollTarget.visibleArea.heightRatio

    // position を **自分で制御しない**
    onPositionChanged: {
        if (!_scrollbar.active) return; // ユーザー操作中だけ反応
        scrollTarget.contentY = position * (scrollTarget.contentHeight - scrollTarget.height)
    }

    // 明示的に更新（ループを避ける）
    Component.onCompleted: {
        _scrollbar.position = scrollTarget.visibleArea.yPosition
    }

    Timer {
        interval: 16
        running: true
        repeat: true
        onTriggered: _scrollbar.position = scrollTarget.visibleArea.yPosition
    }
}
