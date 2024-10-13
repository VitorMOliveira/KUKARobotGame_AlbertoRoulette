import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"

Page {
    id: playernWindow
    width: 1024
    height: 600
    visible: true
    title: qsTr("PLAYERS")


    property string numbers
    property string numbersQT
    property string orderplayersQML
    property string orderQT: myBackend.getOrderPlayers(orderQML)
    property string rectangleTextNumbers
    property string playerOrder
    property string numberChoose
    property string qt_numberchoose:myBackend.getNumberComboBox(numberChoose)
    property string playerDrinks
    property bool rectangle5Visible

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
                console.log("Machine numbersQT: " + numbers)

            }

        }

        //Function to receive player order from  QT
        function onOrderPlayersQML(playerOrder){
            orderplayersQML = playerOrder
        }

        //Function to show player number prompt to choose number
        function onTextNumberChooseQML(rectangleTextNumbers){
            if(numbersQT === "2") {
                if(orderplayersQML === "1"){
                    text3.text = rectangleTextNumbers
                } else if (orderplayersQML === "2"){
                    text2.text = rectangleTextNumbers
                }
            } else if(numbersQT === "4")
                if(orderplayersQML === "1"){
                    text7.text = rectangleTextNumbers
                } else if (orderplayersQML === "2"){
                    text2.text = rectangleTextNumbers
                } else if(orderplayersQML === "3"){
                    text3.text = rectangleTextNumbers
                } else if (orderplayersQML === "4"){
                    text5.text = rectangleTextNumbers
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

        //Function to inform which player goes drink
        function onInformationPlayerDinks(playerDrinks, rectangle5Visible) {
            if(rectangle5Visible === true){
                rectangle5.visible = true
                text9.text = playerDrinks
            } else if(rectangle5Visible === false){
                rectangle5.visible = false
            }
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
            visible: true

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
            visible: true

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
                anchors.leftMargin: 15
                anchors.rightMargin: 15
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
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            visible: true

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
            color: "#f7e275"
            radius: 20
            border.color: "#996515"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            enabled: true
            visible: true

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

        ComboBox {
            id: comboBox
            width: 78
            height: 25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -30
            anchors.leftMargin: 20

            model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                "31", "32", "33", "34", "35", "36"]

        }

        Rectangle {
            id: rectangle5
            x: 486
            y: 236
            width: 403
            height: 56
            visible: false
            color: "#ffffff"
            radius: 15

            Text {
                id: text9
                x: 35
                y: 39
                width: 330
                height: 27
                text: "player 1 drinks"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    CustomButton {
        id: customButton1
        x: 819
        width: 170
        height: 58
        text: "FINNISH"
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
            mainStackLayout.currentIndex = 0
            myBackend.stopThread(true);
        }
    }

    //    CustomButton {
    //        id: customButton2
    //        x: 643
    //        width: 170
    //        text: "CLEAR"
    //        anchors.right: customButton1.left
    //        anchors.top: parent.top
    //        anchors.bottom: parent.bottom
    //        anchors.bottomMargin: 25
    //        anchors.topMargin: 460
    //        anchors.rightMargin: 6
    //        colorPressed: "#740303"
    //        colorMouseOver: "#c80101"
    //        colorDefault: "#d80000"
    //        font.bold: true
    //        font.pointSize: 18

    //        onClicked: {

    //            //Force player 1 play
    //            orderQML = "1"
    //            textOrdedrVisible()

    //            //Clear Text which has chosen numbers
    //            clearTextNumbers=true
    //            clearTextNumbers=false
    //        }
    //    }

    CustomButton {
        id: return_Button
        width: 213
        height: 49
        text: " "
        anchors.left: parent.left
        anchors.top: parent.top
        colorPressed: "#00ffffff"
        colorMouseOver: "#00ffffff"
        colorDefault: "#00ffffff"
        anchors.leftMargin: 102
        anchors.topMargin: -41
        onClicked: {
            console.log("55555555555555555555555")
            numberChoose = comboBox.currentText
            console.log(numberChoose)
        }
    }

    CustomButton {
        id: buttonBuzzer
        y: 575
        width: 20
        height: 20
        text: " "
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 5
        colorPressed: "#00ffffff"
        colorMouseOver: "#00ffffff"
        colorDefault: "#00ffffff"
        anchors.bottomMargin: 5
        enabled: true

        onClicked: {
            if(image79.visible === true){
                image79.visible = false
                myBackend.toastDrink("1")
            } else if(image79.visible === false){
                image79.visible = true
                myBackend.toastDrink("0")
            }
        }

        Image {
            id: image78
            anchors.fill: parent
            source: "qrc:/images/black.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image79
            source: "qrc:/images/cross.png"
            visible: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
