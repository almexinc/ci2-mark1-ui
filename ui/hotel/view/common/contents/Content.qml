import QtQuick 2.15
import QtQuick.Controls 2.15

import "../background"
import "../parts"

BackgroundBase {
    id: _base
    property int date: _vm ? typeof _vm.nowDate === 'number' ? _vm.nowDate : 0 : 0
    property int time: _vm ? typeof _vm.nowTime === 'number' ? _vm.nowTime : 0 : 0
    property string hotelName: _vm ? typeof _vm.hotelName === 'string' ? _vm.hotelName : "" : ""
    property string guidText: _vm ? typeof _vm.guidText === 'string' ? _vm.guidText : "" : ""
    property bool isShowLanguageButton: false
    property bool isShowResetButton: false

    Header {
       id: _header
       date: _base.date
       time: _base.time
       hotelName: _base.hotelName
       isShowLanguageButton: _base.isShowLanguageButton
       isShowResetButton: _base.isShowResetButton
    }

    Footer {
        id: _footer
        guidText: _base.guidText
    }
}
