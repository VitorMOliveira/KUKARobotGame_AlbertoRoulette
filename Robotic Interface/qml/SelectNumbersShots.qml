import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "components"

Page {
    id: selectnWindow1
    width: 1004
    height: 580
    visible: true
    title: qsTr("SELECT NUMBERS")

    property string numbers
    property string numbersQT
    property string orderQML:"1"
    property string orderQT: myBackend.getOrderPlayers(orderQML)
    property string rectangleTextNumbers

    //property to clear Text who press Clear Button
    property bool clearTextNumbers: false
    property bool clearTextNumbersQT: myBackend.clearQList(clearTextNumbers)

    property bool orderAAA
    property bool nextPage

    property int round: 0

    Connections{
        target: myBackend

        //Function to get the players numbers choose. If number = 2 show two Rectangles else 4 Rectangles
        function onNumberPlayersQML(numbers) {
            if(numbers === 2){
                numbersQT = numbers
                rectangle1.height = 60
                rectangle3.height = 60
                rectangle2.visible=false
                rectangle4.visible=false
            } else if (numbers === 4) {
                numbersQT = numbers
                rectangle1.height = 50
                rectangle2.height = 50
                rectangle3.height = 50
                rectangle4.height = 50
                rectangle1.visible=true
                rectangle2.visible=true
                rectangle3.visible=true
                rectangle4.visible=true
            }
            //            console.log("Machine numbersQT: " + numbers)

        }

        //Function to show player number prompt to choose number
        function onTextNumberChooseQML(rectangleTextNumbers){
            if(numbersQT === "2") {
                if(orderQML === "1"){
                    text3.text = rectangleTextNumbers
                } else if (orderQML === "2"){
                    text2.text = rectangleTextNumbers
                }
            } else if(numbersQT === "4"){
                if(orderQML === "1"){
                    text7.text = rectangleTextNumbers
                } else if (orderQML === "2"){
                    text2.text = rectangleTextNumbers
                } else if(orderQML === "3"){
                    text3.text = rectangleTextNumbers
                } else if (orderQML === "4"){
                    text5.text = rectangleTextNumbers
                }
            }

        }

        //Function to clear Text and reset numbers
        function onClearTextQML(clearTextNumbers){
            if(clearTextNumbers === true){
                text2.text = ""
                text3.text = ""
                text5.text = ""
                text7.text = ""
            }
        }

        //Function to next page when all numbers has chosen
        function onNextPage(nextPage){
            if(nextPage === true){
                orderQML = "1"
                mainStackLayout.currentIndex = 3
            }
        }
    }

    //Function to show player nmber alert
    function textOrdedrVisible(){
        rectangle5.visible = true
        text9.text = "Please, player " + orderQML + " choose number"
    }

    //Function to select the player order choose
    function choosePlayerOrder (){

        if(numbersQT === "2") {
            if((orderQML === "1" && orderAAA === true) || (orderQML === "2" && orderAAA === false)){
                //                console.log("111111111111111")
                orderQML = "2"
                textOrdedrVisible()
            } else if (orderQML === "2" && orderAAA === true || (orderQML === "1" && orderAAA === false)){
                //                console.log("22222222222222")
                orderQML = "1"
                textOrdedrVisible()
            }
        } else if(numbersQT === "4")
            if(orderQML === "1"){
                //                console.log("11111111111111")
                orderQML = "2"
                textOrdedrVisible()
            } else if (orderQML === "2"){
                //                console.log("222222222222222")
                orderQML = "3"
                textOrdedrVisible()
            } else if(orderQML === "3"){
                //                console.log("3333333333333")
                orderQML = "4"
                textOrdedrVisible()

            } else if (orderQML === "4"){
                //                console.log("444444444444444")
                orderQML = "1"
                textOrdedrVisible()
            }

    }

    Rectangle {
        id: rectangle
        height: 1004
        width: 580
        color: "#275121"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        ShotGlassNumbers {
            id: tableNumbers
            x: 398
            y: 123
            width: 580
            height: 185
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -10

            onOrderChanged:{
                orderAAA = tableNumbers.order
            }

        }

        Rectangle {
            id: rectangle1
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 348
            anchors.leftMargin: 365
            anchors.topMargin: 21

            Text {
                id: text2
                y: 25
                height: 18
                color: "#000000"
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: text1.right
                anchors.right: parent.right
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 15
                anchors.leftMargin: 15
                anchors.verticalCenterOffset: 0
            }


            Text {
                id: text1
                x: 8
                y: 6
                width: 63
                height: 23
                color: "#000000"
                text: qsTr("Player 1")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0

            }
        }

        Rectangle {
            id: rectangle3
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 27
            anchors.leftMargin: 686
            anchors.topMargin: 21

            Text {
                id: text3
                y: 25
                height: 18
                color: "#000000"
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: text4.right
                anchors.right: parent.right
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 15
                anchors.leftMargin: 15
                anchors.verticalCenterOffset: 0
            }


            Text {
                id: text4
                x: 8
                y: 6
                width: 63
                height: 23
                color: "#000000"
                text: qsTr("Player 2")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0
            }
        }

        Rectangle {
            id: rectangle2
            visible: false
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            Text {
                id: text5
                y: 25
                height: 18
                color: "#000000"
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: text6.right
                anchors.right: parent.right
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 15
                anchors.leftMargin: 15
                anchors.verticalCenterOffset: 0
            }

            Text {
                id: text6
                x: 8
                y: 6
                width: 63
                height: 23
                color: "#000000"
                text: qsTr("Player 3")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0
            }
            anchors.leftMargin: 365
            anchors.topMargin: 80
            anchors.rightMargin: 348
        }

        Rectangle {
            id: rectangle4
            visible: false
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            enabled: true

            Text {
                id: text7
                y: 25
                height: 18
                color: "#000000"
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: text8.right
                anchors.right: parent.right
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 15
                anchors.leftMargin: 15
                anchors.verticalCenterOffset: 0
            }

            Text {
                id: text8
                x: 8
                y: 6
                width: 63
                height: 23
                color: "#000000"
                text: qsTr("Player 4")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0
            }
            anchors.leftMargin: 686
            anchors.topMargin: 80
            anchors.rightMargin: 27
        }

        Image {
            id: image1
            x: 16
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 10.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image2
            x: 77
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 50.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image3
            x: 138
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 100.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image4
            x: 199
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 1k.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image6
            x: 260
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 100k.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image7
            x: 321
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 500K.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image8
            x: 382
            y: 479
            width: 55
            height: 55
            anchors.bottom: parent.bottom
            source: "../images/Chips/Chip 1M.png"
            anchors.bottomMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rectangle5
            x: 486
            y: 236
            width: 403
            height: 56
            visible: true
            color: "#ffffff"
            radius: 15

            Text {
                id: text9
                x: 35
                y: 39
                width: 330
                height: 27
                text: "Please, player 1 choose number"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Timer{
                id: myTimer1
                interval: 3000
                running: false
                repeat: false
                onTriggered: {
                    rectangle5.visible = false
                }
            }
        }
    }

    CustomButton {
        id: customButton
        x: 819
        width: 170
        height: 58
        visible: false
        text: "NEXT"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        enabled: false
        anchors.topMargin: 359
        anchors.bottomMargin: 126
        anchors.rightMargin: 15
        //        gradient: Gradient {
        //            GradientStop { position: 0.0; color: "#DAA520" }
        //            GradientStop { position: 0.25; color: "white" }
        //            GradientStop { position: 1.0; color: "#DAA520" }
        //        }
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        font.bold: true
        font.pointSize: 18

        onClicked: {
            orderQML = "1"
            mainStackLayout.currentIndex = 3
        }
    }

    CustomButton {
        id: customButton1
        x: 819
        width: 170
        height: 58
        text: "CHOOSE"
        anchors.right: customButton.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.topMargin: 460
        anchors.rightMargin: -170
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        font.bold: true
        font.pointSize: 18
        onClicked: {
            //Choose number
            choosePlayerOrder()

            //Change the order to false so the player's order is not changed
            //when pressing the button without having chosen number
            tableNumbers.order = false

            round++
            myBackend.getRound_2(round)

        }

        Timer{
            id: myTimer
            interval: 3000
            running: true
            repeat: true
            onTriggered: {
                rectangle5.visible = false
            }
        }
    }

    CustomButton {
        id: customButton2
        x: 643
        width: 170
        text: "CLEAR"
        anchors.right: customButton1.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.topMargin: 460
        anchors.rightMargin: 6
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        font.bold: true
        font.pointSize: 18

        onClicked: {

            myBackend.clearQList(true)

            //Force player 1 play
            orderQML = "1"
            textOrdedrVisible()

            //Clear Text which has chosen numbers
            clearTextNumbers=true
            clearTextNumbers=false
        }
    }

    CustomButton {
        id: btnConfirm
        width: 25
        height: 25
        opacity: 1
        text: "<"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: -30
        font.bold: true
        font.pointSize: 12
        colorPressed: "#ea1043"
        colorMouseOver: "#bc0c35"
        colorDefault: "#ea1043"
        onClicked: {
            mainStackLayout.currentIndex = 1
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
