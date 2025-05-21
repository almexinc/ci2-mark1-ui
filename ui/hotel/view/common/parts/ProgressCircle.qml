import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
//import QtGraphicalEffects 1.15
import "../button"
import "../text"
import "../base"

Item {
    id: _ProgressCircle
    property int percentage: 75 // 0〜100
    property string centerText: "取引\n完了まで"
    width: 130
    height: 130

    property real markerX: 0
    property real markerY: 0

    anchors {
        top: parent.top;topMargin: Window.height > constants.breakPointHeight ? 50 : 20
        right: parent.right;rightMargin: 30
    }

    Canvas {
        id: ringCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - 10;
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + (2 * Math.PI * _ProgressCircle.percentage / 100);

            // 背景リング
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
            ctx.lineWidth = 10;
            ctx.strokeStyle = "#d9d9d9";
            ctx.stroke();

            // 進捗リング
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
            ctx.lineWidth = 10;
            ctx.strokeStyle = "#c9921e";
            ctx.stroke();

            _ProgressCircle.markerX = centerX + radius * Math.cos(endAngle);
            _ProgressCircle.markerY = centerY + radius * Math.sin(endAngle);
        }

        Component.onCompleted: requestPaint()

        Connections {
            target: _ProgressCircle
            onPercentageChanged: ringCanvas.requestPaint()
        }
    }


    // 中央テキスト
    BaseText {
        id: centerLabel
        text: _ProgressCircle.centerText
        anchors.centerIn: parent
        color: "#c9921e"
        font.bold: true
        font.pixelSize: 22
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // チェックアイコン
    BaseImage {
        id: checkImage
        source: "../../../img/icon/check.png"
        width: 30
        height: 30
        x: _ProgressCircle.markerX - width / 2
        y: _ProgressCircle.markerY - height / 2
    }
}
