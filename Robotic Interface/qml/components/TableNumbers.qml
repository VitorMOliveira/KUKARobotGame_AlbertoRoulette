import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: item1
    width: 560
    height: 242
    opacity: 1
    visible: true

    property string numberText
    property string numberTextQT
    property string numberChoose: myBackend.chooseTableNumbers(numberTextQT)
    property bool crossNumberVisible

    //Fuction to defne is number is choosen ou not
    function chooseNumber (){
        if(crossNumberVisible === false){
            numberTextQT = "f." + numberText
        } else{
            numberTextQT = "t." + numberText
        }
    }

    Numbers {
        id: number1
        x: 28
        y: 139
        width: 46
        height: 70
        Text{
            id: tnumber1
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("1")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            //obtain the glass id
            numberText = tnumber1.text
            //checks if numbers has choosen
            chooseNumber(numberText)
//            console.log(tnumber1.text)
        }

        onCrossVisibleChanged:{
            //Show cross or not
            crossNumberVisible = number1.crossVisible
//            console.log(number1.crossVisible + "111111111")
        }
    }

    Numbers {
        id: number2
        x: 28
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text{
            id: tnumber2
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("2")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber2.text
//            console.log(tnumber2.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number2.crossVisible
        }
    }

    Numbers {
        id: number3
        x: 28
        y: 3
        width: 46
        height: 70
        Text{
            id: tnumber3
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("3")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber3.text
//            console.log(tnumber3.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number3.crossVisible
        }
    }

    Numbers {
        id: number4
        x: 72
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text{
            id: tnumber4
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("4")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber4.text
//            console.log(tnumber4.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number4.crossVisible
        }
    }

    Numbers {
        id: number5
        x: 72
        y: 71
        width: 46
        height: 70
        Text{
            id: tnumber5
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("5")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber5.text
//            console.log(tnumber5.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number5.crossVisible
        }
    }

    Numbers {
        id: number6
        x: 72
        y: 3
        width: 46
        height: 70
        colorDefault: "#000000"
        Text{
            id: tnumber6
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("6")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber6.text
//            console.log(tnumber6.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number6.crossVisible
        }
    }

    Numbers {
        id: number7
        x: 116
        y: 139
        width: 46
        height: 70
        Text {
            id: tnumber7
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("7")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber7.text
//            console.log(tnumber7.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number7.crossVisible
        }
    }

    Numbers {
        id: number8
        x: 116
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber8
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("8")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber8.text
//            console.log(tnumber8.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number8.crossVisible
        }
    }

    Numbers {
        id: number9
        x: 116
        y: 3
        width: 46
        height: 70
        Text {
            id: tnumber9
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("9")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber9.text
//            console.log(tnumber9.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number9.crossVisible
        }
    }

    Numbers {
        id: number10
        x: 160
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber10
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("10")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber10.text
//            console.log(tnumber10.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number10.crossVisible
        }
    }

    Numbers {
        id: number11
        x: 160
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber11
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("11")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber11.text
//            console.log(tnumber11.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number11.crossVisible
        }
    }

    Numbers {
        id: number12
        x: 160
        y: 3
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber12
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("12")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber12.text
//            console.log(tnumber12.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number12.crossVisible
        }
    }

    Numbers {
        id: number13
        x: 204
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber13
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("13")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber13.text
//            console.log(tnumber13.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number13.crossVisible
        }
    }

    Numbers {
        id: number14
        x: 204
        y: 71
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber14
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("14")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber14.text
//            console.log(tnumber14.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number14.crossVisible
        }
    }

    Numbers {
        id: number15
        x: 204
        y: 3
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber15
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("15")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber15.text
//            console.log(tnumber15.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number15.crossVisible
        }
    }

    Numbers {
        id: number16
        x: 248
        y: 139
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber16
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("16")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber16.text
//            console.log(tnumber16.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number16.crossVisible
        }
    }

    Numbers {
        id: number17
        x: 248
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber17
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("17")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber17.text
//            console.log(tnumber17.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number17.crossVisible
        }
    }

    Numbers {
        id: number18
        x: 248
        y: 3
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber18
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("18")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber18.text
//            console.log(tnumber18.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number18.crossVisible
        }
    }

    Numbers {
        id: number19
        x: 292
        y: 139
        width: 46
        height: 70
        Text {
            id: tnumber19
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("19")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber19.text
//            console.log(tnumber19.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number19.crossVisible
        }
    }

    Numbers {
        id: number20
        x: 292
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber20
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("20")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber20.text
//            console.log(tnumber20.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number20.crossVisible
        }
    }

    Numbers {
        id: number21
        x: 292
        y: 3
        width: 46
        height: 70
        Text {
            id: tnumber21
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("21")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber21.text
//            console.log(tnumber21.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number21.crossVisible
        }
    }

    Numbers {
        id: number22
        x: 336
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber22
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("22")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber22.text
//            console.log(tnumber22.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number22.crossVisible
        }
    }

    Numbers {
        id: number23
        x: 336
        y: 71
        width: 46
        height: 70
        Text {
            id: tnumber23
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("23")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber23.text
//            console.log(tnumber23.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number23.crossVisible
        }
    }

    Numbers {
        id: number24
        x: 336
        y: 3
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber24
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("24")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber24.text
//            console.log(tnumber24.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number24.crossVisible
        }
    }

    Numbers {
        id: number25
        x: 380
        y: 139
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber25
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("25")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber25.text
//            console.log(tnumber25.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number25.crossVisible
        }
    }

    Numbers {
        id: number26
        x: 380
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber26
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("26")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber26.text
//            console.log(tnumber26.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number26.crossVisible
        }
    }

    Numbers {
        id: number27
        x: 380
        y: 3
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber27
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("27")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber27.text
//            console.log(tnumber27.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number27.crossVisible
        }
    }

    Numbers {
        id: number28
        x: 424
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber28
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("28")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber28.text
//            console.log(tnumber28.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number28.crossVisible
        }
    }

    Numbers {
        id: number29
        x: 424
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber29
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("29")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber29.text
//            console.log(tnumber29.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number29.crossVisible
        }
    }

    Numbers {
        id: number30
        x: 424
        y: 3
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber30
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("30")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber30.text
//            console.log(tnumber30.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number30.crossVisible
        }
    }

    Numbers {
        id: number31
        x: 468
        y: 139
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber31
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("31")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber31.text
//            console.log(tnumber31.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number31.crossVisible
        }
    }

    Numbers {
        id: number32
        x: 468
        y: 71
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber32
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("32")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber32.text
//            console.log(tnumber32.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number32.crossVisible
        }
    }

    Numbers {
        id: number33
        x: 468
        y: 3
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber33
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("33")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber33.text
//            console.log(tnumber33.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number33.crossVisible
        }
    }

    Numbers {
        id: number34
        x: 512
        y: 139
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber34
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("34")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber34.text
//            console.log(tnumber34.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number34.crossVisible
        }
    }

    Numbers {
        id: number35
        x: 512
        y: 71
        width: 46
        height: 70
        colorDefault: "#000000"
        Text {
            id: tnumber35
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("35")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber35.text
//            console.log(tnumber35.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number35.crossVisible
        }
    }

    Numbers {
        id: number36
        x: 512
        y: 3
        width: 46
        height: 70
        colorDefault: "#f00000"
        Text {
            id: tnumber36
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("36")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            numberText = tnumber36.text
//            console.log(tnumber36.text)
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = number36.crossVisible
        }
    }

    Rectangle{
        x: 0
        y: 3
        color: "#00ffffff"
        width: 27
        height: 206

        Text {
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("0")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: rectangle
            x: 5
            y: 0
            width: 27
            height: 2
            color: "#ffffff"
        }

        Rectangle {
            id: rectangle1
            x: 5
            y: 204
            width: 27
            height: 2
            color: "#ffffff"
        }

        Rectangle {
            id: rectangle3
            x: -52
            y: 154
            width: 104
            height: 2
            color: "#ffffff"
            rotation: 85
        }

        Rectangle {
            id: rectangle4
            x: -52
            y: 50
            width: 104
            height: 2
            color: "#ffffff"
            rotation: 95

        }

        Rectangle {
            id: rectangle5
            x: 2
            y: 206
            width: 5
            height: 2
            color: "#275121"
        }

        Rectangle {
            id: rectangle6
            x: 3
            y: -2
            width: 5
            height: 2
            color: "#275121"
        }
    }

    Rectangle {
        id: rectangle2
        x: 28
        y: 209
        width: 178
        height: 32
        color: "#ffffff"

        Rectangle {
            id: rectangle7
            x: 2
            y: 0
            width: 176
            height: 30
            color: "#275121"
        }

        Text {
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("1st 12")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: rectangle8
        x: 204
        y: 209
        width: 178
        height: 32
        color: "#ffffff"
        Rectangle {
            id: rectangle9
            x: 2
            y: 0
            width: 174
            height: 30
            color: "#275121"
        }

        Text {
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("2hd 12")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: rectangle10
        x: 380
        y: 209
        width: 178
        height: 32
        color: "#ffffff"
        Rectangle {
            id: rectangle11
            x: 2
            y: 0
            width: 174
            height: 30
            color: "#275121"
        }

        Text {
            x: 27
            y: 10
            color: "#ffffff"
            text: qsTr("3rd 12")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
