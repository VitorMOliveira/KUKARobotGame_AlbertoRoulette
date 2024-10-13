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
//    title: qsTr("SELECT NUMBERS")

//    property string numbers
//    property string order
//    property string name
//    property string playerChoose
//    property string orderQML:"1"
//    property string orderQT: myBackend.getOrderPlayers(orderQML)
//    property string numberChoose
//    property string sendNumberChooseQT: myBackend.getNumberChooseQML(numberChoose)
//    property bool rectangle5Visible: false
//    property string rectangleTextNumbers
//    property bool clearTextNumbers: false
//    property bool clearTextNumbersQT: myBackend.clearQlist(clearTextNumbers)

//    Connections{
//        target: myBackend

//        function onNumberPlayersQML(numbers) {
//            if(numbers === 2){
//                name = numbers
//                rectangle2.visible=false
//                rectangle4.visible=false
//            } else if (numbers === 4) {
//                name = numbers
//                rectangle2.visible=true
//                rectangle4.visible=true
//            }
//            //            console.log("Machine Name: " + numbers)

//        }

//        function onTextNumberChooseQML(rectangleTextNumbers){
//            if(name === "2") {
//                if(orderQML === "1"){
//                    text3.text = rectangleTextNumbers
//                } else if (orderQML === "2"){
//                    text2.text = rectangleTextNumbers
//                }
//            } else if(name === "4")
//                if(orderQML === "1"){
//                    text2.text = rectangleTextNumbers
//                } else if (orderQML === "2"){
//                    text3.text = rectangleTextNumbers
//                } else if(orderQML === "3"){
//                    text5.text = rectangleTextNumbers
//                } else if (orderQML === "4"){
//                    text7.text = rectangleTextNumbers
//                }
//        }

//        function onClearTextQML(clearTextNumbers){
//            if(clearTextNumbers === true){
//                text2.text = ""
//                text3.text = ""
//                text5.text = ""
//                text7.text = ""
//            }
//        }

//        //        function onPlayerOrder(order, numbers){
//        //            if(numbers === "2"){
//        //                console.log("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
//        //                if(order === "1"){
//        //                    playerChoose = order
//        //                    rectangle5.visible = true
//        //                    text9.text = "Please, player " + playerChoose + " choose number"
//        //                    console.log("mmmmmmmm " + order)
//        //                    playerChoose = "2"
//        //                } else if(order === "2"){
//        //                    playerChoose = order
//        //                    rectangle5.visible = true
//        //                    text9.text = "Please, player " + playerChoose + " choose number"
//        //                    playerChoose = "1"
//        //                    console.log("yyyyyyyyyyyyyyyyy " + order)
//        //                }



//        //                //            } else if(order === "4"){
//        //                //                playerChoose = order
//        //                //                console.log("yyyyyyyyyyyyyyyyy ")
//        //                //            }
//        //            }
//        //        }
//    }

//    function textOrdedrVisible(){
//        rectangle5.visible = true
//        text9.text = "Please, player " + orderQML + " choose number"
//    }

//    function choosePlayerOrder (){
//        if(name === "2") {
//            if(orderQML === "1"){
//                //                console.log("111111111111111")
//                orderQML = "2"
//                textOrdedrVisible()
//            } else if (orderQML === "2"){
//                //                console.log("22222222222222")
//                orderQML = "1"
//                textOrdedrVisible()
//            }
//        } else if(name === "4")
//            if(orderQML === "1"){
//                //                console.log("11111111111111")
//                orderQML = "2"
//                textOrdedrVisible()
//            } else if (orderQML === "2"){
//                //                console.log("222222222222222")
//                orderQML = "3"
//                textOrdedrVisible()
//            } else if(orderQML === "3"){
//                //                console.log("3333333333333")
//                orderQML = "4"
//                textOrdedrVisible()

//            } else if (orderQML === "4"){
//                //                console.log("444444444444444")
//                orderQML = "1"
//                textOrdedrVisible()
//            }

//    }

//    //    function playerNumberChoose(name, playerChoose){
//    //        if (name === "2"){
//    //            if(playerChoose === "1" || playerChoose === 1 || playerChoose === ""){
//    //                console.log("777777777777777")
//    //                console.log("mmmmmmmm " + playerChoose)
//    //                console.log("44444444444444")
//    //                playerChoose = "2"
//    //                console.log("zzzzzzzzzzzzz " + playerChoose)
//    //                console.log("9999999999999999")
//    //            } else if (playerChoose === "2" || playerChoose === 2){
//    //                playerChoose = "1"
//    //                console.log("99999999999999")
//    //            }
//    //        }
//    //        console.log("tttttttttttttttttt " + playerChoose)

//    //    }
//    Rectangle {
//        id: rectangle
//        color: "#275121"
//        anchors.fill: parent
//        anchors.rightMargin: 0
//        anchors.bottomMargin: 0
//        anchors.leftMargin: 0
//        anchors.topMargin: 0

//        Rectangle {
//            id: rectangle9
//            x: 347
//            y: 268
//            width: 63
//            height: 106
//            color: "#275121"
//        }

//        TableNumbers {
//            id: tableNumbers
//            x: 420
//            y: 123
//            width: 557
//            height: 239
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.verticalCenterOffset: -10

//        }

//        ShotGlass {
//            id: shotGlass
//            x: 745
//            y: 405
//            width: 100
//            height: 64
//        }

//        Rectangle {
//            id: rectangle1
//            color: "#f7e275"
//            radius: 20
//            border.color: "#996515"
//            border.width: 5
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 475
//            anchors.rightMargin: 348
//            anchors.leftMargin: 365
//            anchors.topMargin: 21

//            Text {
//                id: text2
//                x: 101
//                y: 25
//                width: 176
//                height: 18
//                color: "#000000"
//                text: ""
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 0
//            }


//            Text {
//                id: text1
//                x: 8
//                y: 6
//                width: 63
//                height: 23
//                color: "#000000"
//                text: qsTr("Player 1")
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 1

//            }
//        }

//        Rectangle {
//            id: rectangle3
//            color: "#f7e275"
//            radius: 20
//            border.color: "#996515"
//            border.width: 5
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.rightMargin: 27
//            anchors.leftMargin: 686
//            anchors.bottomMargin: 475
//            anchors.topMargin: 21

//            Text {
//                id: text3
//                x: 101
//                y: 25
//                width: 176
//                height: 18
//                color: "#000000"
//                text: ""
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 0
//            }


//            Text {
//                id: text4
//                x: 8
//                y: 6
//                width: 63
//                height: 23
//                color: "#000000"
//                text: qsTr("Player 2")
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 1
//            }
//        }

//        Rectangle {
//            id: rectangle2
//            visible: false
//            color: "#f7e275"
//            radius: 20
//            border.color: "#996515"
//            border.width: 5
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            Text {
//                id: text5
//                x: 101
//                y: 25
//                width: 176
//                height: 18
//                color: "#000000"
//                text: ""
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 0
//            }

//            Text {
//                id: text6
//                x: 8
//                y: 6
//                width: 63
//                height: 23
//                color: "#000000"
//                text: qsTr("Player 3")
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 1
//            }
//            anchors.leftMargin: 365
//            anchors.topMargin: 80
//            anchors.rightMargin: 348
//            anchors.bottomMargin: 416
//        }

//        Rectangle {
//            id: rectangle4
//            visible: false
//            color: "#f7e275"
//            radius: 20
//            border.color: "#996515"
//            border.width: 5
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            enabled: true
//            Text {
//                id: text7
//                x: 101
//                y: 25
//                width: 176
//                height: 18
//                color: "#000000"
//                text: ""
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 0
//            }

//            Text {
//                id: text8
//                x: 8
//                y: 6
//                width: 63
//                height: 23
//                color: "#000000"
//                text: qsTr("Player 4")
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 15
//                horizontalAlignment: Text.AlignHCenter
//                anchors.verticalCenterOffset: 1
//            }
//            anchors.leftMargin: 686
//            anchors.topMargin: 80
//            anchors.rightMargin: 27
//            anchors.bottomMargin: 416
//        }

//        Image {
//            id: image1
//            x: 16
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 10.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image2
//            x: 77
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 50.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image3
//            x: 138
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 100.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image4
//            x: 199
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 1k.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image6
//            x: 260
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 100k.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image7
//            x: 321
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 500K.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Image {
//            id: image8
//            x: 382
//            y: 479
//            width: 55
//            height: 55
//            anchors.bottom: parent.bottom
//            source: "../images/Chips/Chip 1M.png"
//            anchors.bottomMargin: 25
//            fillMode: Image.PreserveAspectFit
//        }

//        Rectangle {
//            id: rectangle5
//            x: 486
//            y: 236
//            width: 403
//            height: 56
//            visible: true
//            color: "#ffffff"
//            radius: 15

//            Text {
//                id: text9
//                x: 35
//                y: 39
//                width: 330
//                height: 27
//                text: "Please, player 1 choose number"
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 20
//                horizontalAlignment: Text.AlignHCenter
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

//            Timer{
//                id: myTimer1
//                interval: 3000
//                running: false
//                repeat: false
//                onTriggered: {
//                    rectangle5.visible = false
//                }
//            }
//        }

//        ShotGlass {
//            id: shotGlass1
//            x: 782
//            y: 114
//        }
//    }

//    CustomButton {
//        id: customButton
//        x: 802
//        width: 170
//        height: 58
//        text: "NEXT"
//        anchors.right: parent.right
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.topMargin: 460
//        anchors.bottomMargin: 25
//        anchors.rightMargin: 15
//        //        gradient: Gradient {
//        //            GradientStop { position: 0.0; color: "#DAA520" }
//        //            GradientStop { position: 0.25; color: "white" }
//        //            GradientStop { position: 1.0; color: "#DAA520" }
//        //        }
//        colorPressed: "#740303"
//        colorMouseOver: "#c80101"
//        colorDefault: "#d80000"
//        font.bold: true
//        font.pointSize: 18

//        onClicked: {
//            orderQML = "1"
//            mainStackLayout.currentIndex = 3
//        }
//    }

//    CustomButton {
//        id: customButton1
//        x: 616
//        width: 170
//        height: 58
//        text: "CHOOSE"
//        anchors.right: customButton.left
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 25
//        anchors.topMargin: 460
//        anchors.rightMargin: 8
//        colorPressed: "#740303"
//        colorMouseOver: "#c80101"
//        colorDefault: "#d80000"
//        font.bold: true
//        font.pointSize: 18
//        onClicked: {
//            choosePlayerOrder()
//            //            orderQT(order)
//            //            onPlayerOrder(order, numbers)

//            //            console.log("iiiiiiiiiiiiiiii " + playerChoose)
//            //            playerNumberChoose(name, playerChoose)
//            //            console.log(playerChoose)

//        }

//        Timer{
//            id: myTimer
//            interval: 3000
//            running: true
//            repeat: true
//            onTriggered: {
//                rectangle5.visible = false
//            }
//        }
//    }

//    CustomButton {
//        id: customButton2
//        x: 430
//        width: 170
//        text: "CLEAR"
//        anchors.right: customButton1.left
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 25
//        anchors.topMargin: 460
//        anchors.rightMargin: 8
//        colorPressed: "#740303"
//        colorMouseOver: "#c80101"
//        colorDefault: "#d80000"
//        font.bold: true
//        font.pointSize: 18

//        onClicked: {
//            clearTextNumbersQT=true
//        }
//    }
}











/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
