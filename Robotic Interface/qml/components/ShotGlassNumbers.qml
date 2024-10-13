import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: item1
    width: 580
    height: 185
    opacity: 1
    visible: true

    property string numberText
    property string numberTextQT
    property bool crossNumberVisible
    property string numberSelect
    property bool enabledGlassID
    property bool crossVisible1
    property string glass_id

    //property to sends QT if number has choosen or not
    property string numberChoose: myBackend.chooseTableNumbers(numberTextQT)

    property bool order

    Connections{
        target: myBackend

        //Function to disable the cross for when press the number and choose block
        function onEnableCrossNumber(numberSelect,enabledGlassID) {
            if(numberSelect === "1"){
                shotGlass1.enabled = enabledGlassID
            } else if(numberSelect === "2"){
                shotGlass2.enabled = enabledGlassID
            } else if(numberSelect === "3"){
                shotGlass3.enabled = enabledGlassID
            } else if(numberSelect === "4"){
                shotGlass4.enabled = enabledGlassID
            } else if(numberSelect === "5"){
                shotGlass5.enabled = enabledGlassID
            } else if(numberSelect === "6"){
                shotGlass6.enabled = enabledGlassID
            } else if(numberSelect === "7"){
                shotGlass7.enabled = enabledGlassID
            } else if(numberSelect === "8"){
                shotGlass8.enabled = enabledGlassID
            } else if(numberSelect === "9"){
                shotGlass9.enabled = enabledGlassID
            } else if(numberSelect === "10"){
                shotGlass10.enabled = enabledGlassID
            } else if(numberSelect === "11"){
                shotGlass11.enabled = enabledGlassID
            } else if(numberSelect === "12"){
                shotGlass12.enabled = enabledGlassID
            } else if(numberSelect === "13"){
                shotGlass13.enabled = enabledGlassID
            } else if(numberSelect === "14"){
                shotGlass14.enabled = enabledGlassID
            } else if(numberSelect === "15"){
                shotGlass15.enabled = enabledGlassID
            } else if(numberSelect === "16"){
                shotGlass16.enabled = enabledGlassID
            } else if(numberSelect === "0"){

                //disable all numbers to nextPage when players to play
                shotGlass1.enabled = enabledGlassID
                shotGlass2.enabled = enabledGlassID
                shotGlass3.enabled = enabledGlassID
                shotGlass4.enabled = enabledGlassID
                shotGlass5.enabled = enabledGlassID
                shotGlass6.enabled = enabledGlassID
                shotGlass7.enabled = enabledGlassID
                shotGlass8.enabled = enabledGlassID
                shotGlass9.enabled = enabledGlassID
                shotGlass10.enabled = enabledGlassID
                shotGlass11.enabled = enabledGlassID
                shotGlass12.enabled = enabledGlassID
                shotGlass13.enabled = enabledGlassID
                shotGlass14.enabled = enabledGlassID
                shotGlass15.enabled = enabledGlassID
                shotGlass16.enabled = enabledGlassID
            }
        }

        //Function to visible the cross for when number exit
        function onVisibleCrossGlassID(glass_id, crossVisible1) {
            if(glass_id === "1"){
                shotGlass1.crossVisible = crossVisible1
            } else if(glass_id === "2"){
                shotGlass2.crossVisible = crossVisible1
            } else if(glass_id === "3"){
                shotGlass3.crossVisible = crossVisible1
            } else if(glass_id === "4"){
                shotGlass4.crossVisible = crossVisible1
            } else if(glass_id === "5"){
                shotGlass5.crossVisible = crossVisible1
            } else if(glass_id === "6"){
                shotGlass6.crossVisible = crossVisible1
            } else if(glass_id === "7"){
                shotGlass7.crossVisible = crossVisible1
            } else if(glass_id === "8"){
                shotGlass8.crossVisible = crossVisible1
            } else if(glass_id === "9"){
                shotGlass9.crossVisible = crossVisible1
            } else if(glass_id === "10"){
                shotGlass10.crossVisible = crossVisible1
            } else if(glass_id === "11"){
                shotGlass11.crossVisible = crossVisible1
            } else if(glass_id === "12"){
                shotGlass12.crossVisible = crossVisible1
            } else if(glass_id === "13"){
                shotGlass13.crossVisible = crossVisible1
            } else if(glass_id === "14"){
                shotGlass14.crossVisible = crossVisible1
            } else if(glass_id === "15"){
                shotGlass15.crossVisible = crossVisible1
            } else if(glass_id === "16"){
                shotGlass16.crossVisible = crossVisible1
            } else if(glass_id === "0"){

                //invisible all cross to nextPage when players to play
                shotGlass1.crossVisible = crossVisible1
                shotGlass2.crossVisible = crossVisible1
                shotGlass3.crossVisible = crossVisible1
                shotGlass4.crossVisible = crossVisible1
                shotGlass5.crossVisible = crossVisible1
                shotGlass6.crossVisible = crossVisible1
                shotGlass7.crossVisible = crossVisible1
                shotGlass8.crossVisible = crossVisible1
                shotGlass9.crossVisible = crossVisible1
                shotGlass10.crossVisible = crossVisible1
                shotGlass11.crossVisible = crossVisible1
                shotGlass12.crossVisible = crossVisible1
                shotGlass13.crossVisible = crossVisible1
                shotGlass14.crossVisible = crossVisible1
                shotGlass15.crossVisible = crossVisible1
                shotGlass16.crossVisible = crossVisible1
            }
        }
    }

    //Fuction to defne is number is choosen ou not
    function chooseNumber (){
        if(crossNumberVisible === false){
            numberTextQT = "f." + numberText
            order = false
        } else{
            numberTextQT = "t." + numberText
            order = true
        }
    }

    ShotGlass {
        id: shotGlass1
        x: 0
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass1
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "1 3 36"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass1
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "1"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            //obtain the glass id
            numberText = idShotGlass1.text
            //checks if numbers has choosen
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            //Show cross or not
            crossNumberVisible = shotGlass1.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass2
        x: 73
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass2
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "5 34"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass2
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass2.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass2.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass3
        x: 146
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass3
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "7 32"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass3
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "3"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass3.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass3.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass4
        x: 219
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass4
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "9 30"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass4
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "4"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass4.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass4.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass5
        x: 292
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass5
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "12 19"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass5
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "5"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass5.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass5.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass6
        x: 365
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass6
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "14 16 23"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass6
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "6"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass6.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass6.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass7
        x: 438
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass7
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "18 21"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass7
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "7"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass7.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass7.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass8
        x: 511
        y: 0
        width: 67
        height: 89
        imageSource: "qrc:/images/red.png"

        Text {
            id: textShotGlass8
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "25 27"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass8
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "8"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass8.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass8.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass9
        x: 0
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass9
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "2 28 35"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass9
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "9"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass9.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass9.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass10
        x: 73
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass10
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "4 33"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass10
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "10"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass10.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass10.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass11
        x: 146
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass11
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "6 31"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass11
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "11"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass11.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass11.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass12
        x: 219
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass12
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "8 29"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass12
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "12"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass12.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass12.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass13
        x: 292
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass13
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "10 13 24"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass13
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "13"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass13.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass13.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass14
        x: 365
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass14
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "11 26"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass14
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "14"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass14.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass14.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass15
        x: 438
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass15
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "15 22"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass15
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "15"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass15.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass15.crossVisible
        }
    }

    ShotGlass {
        id: shotGlass16
        x: 511
        y: 95
        width: 67
        height: 89
        imageSource: "qrc:/images/black.png"

        Text {
            id: textShotGlass16
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "17 20"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
        }

        Text {
            id: idShotGlass16
            x: 8
            y: 25
            width: 51
            height: 24
            color: "#ffffff"
            text: "16"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 11
            visible: false
        }

        onClicked: {
            numberText = idShotGlass16.text
            chooseNumber(numberText)
        }

        onCrossVisibleChanged:{
            crossNumberVisible = shotGlass16.crossVisible
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
