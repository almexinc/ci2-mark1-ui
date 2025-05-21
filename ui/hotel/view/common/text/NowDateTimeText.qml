import QtQuick 2.15
import QtQuick.Controls 2.15
import "../text"

DefaultText {
    id: _defaultText
    property int nowDate: 20241215 // 年月日を YYYYMMDD の形式で表現
    property int nowTime: 1210 // 時間を HHMM の形式で表現
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
    text: ""
    font.pixelSize: 20

    Component.onCompleted: {
        _defaultText.text = formatDateAndTime(nowDate, nowTime);
    }

    function formatDateAndTime(date, time) {
        var year = Math.floor(date / 10000);
        var month = Math.floor((date % 10000) / 100);
        var day = date % 100;
        var weekday = getWeekday(date);
        var hour = Math.floor(time / 100)
        var minute = time % 100

        return year + " / " + paddingTime(month) + " / " + paddingTime(day) + " (" + weekday + ") " + paddingTime(hour) + "：" + paddingTime(minute);
    }

    /**
     * @brief 引数の数値を0埋めパディングの２桁文字列で出力させる
     * @param (num) 0埋めパディングさせたい数値
     */
    function paddingTime(num){
        return num.toString().padStart(2, '0');
    }

    /**
     * @brief 引数の日付から曜日を取得する
     * @param (date) YYYYMMDD形式の日付
     * @return 曜日を表す文字列
     */
    function getWeekday(date) {
        // 日付をDateオブジェクトに変換
        var dateStr = date.toString();
        var year = parseInt(dateStr.substring(0, 4));
        var month = parseInt(dateStr.substring(4, 6)) - 1; // 月は0から始まるので-1する
        var day = parseInt(dateStr.substring(6, 8));
        var d = new Date(year, month, day);

        // 曜日の配列
        var daysOfWeek = ["日", "月", "火", "水", "木", "金", "土"];
        // 曜日を取得
        return daysOfWeek[d.getDay()];
    }
}
