import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12

import "components"

Page {
    id: playersnWindow
    width: 1004
    height: 540
    visible: true
    title: qsTr("PLAYERS")

    //property to get nummber players who choose
    property string  numberPlayers
    property var rectanglePlayers: myBackend.getNumbersPlayers(numberPlayers)

    Rectangle {
        id: rectangle
        color: "#275121"
        anchors.fill: parent

        CheckBox {
            id: checkBox
            x: 8
            y: 492
            text: "Random Cups"
            checked: true
        }
    }

    CustomButton {
        id: players2_Button
        x: 513
        y: 333
        width: 230
        height: 72
        text: "2 PLAYERS"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 135
        anchors.rightMargin: 261
        font.bold: true
        font.pointSize: 25
        focusPolicy: Qt.WheelFocus
        display: AbstractButton.TextOnly
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        onClicked: {
            numberPlayers=2
            mainStackLayout.currentIndex = 2
            myBackend.randonGenerateCus(checkBox.checkState)
        }
    }

    CustomButton {
        id: players4_Button
        x: 753
        y: 333
        width: 230
        height: 72
        text: "4 PLAYERS"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.bold: true
        font.pointSize: 25
        focusPolicy: Qt.WheelFocus
        display: AbstractButton.TextOnly
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        anchors.rightMargin: 21
        anchors.bottomMargin: 135
        onClicked: {
            numberPlayers=4
            mainStackLayout.currentIndex = 2
            myBackend.randonGenerateCus(checkBox.checkState)
        }
    }

    CustomButton {
        id: newGame_Button
        x: 629
        y: 419
        width: 241
        height: 72
        visible: false
        text: "NEW GAME"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        enabled: false
        autoExclusive: false
        font.bold: true
        font.pointSize: 25
        focusPolicy: Qt.WheelFocus
        display: AbstractButton.TextOnly
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        anchors.rightMargin: 135
        anchors.bottomMargin: 49
        onClicked: {
            mainStackLayout.currentIndex = 0
        }

    }

    AlbertoRoullete{
        id: image1
        x: 571
        width: 430
        height: 250
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 3
        anchors.topMargin: 10
    }

    Image {
        id: image9
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.top: parent.top
        source: "../images/Chips/Chip 100k.png"
        anchors.leftMargin: 393
        anchors.topMargin: 57
        rotation: -26.153
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image2
        y: 499
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 1M.png"
        anchors.leftMargin: 247
        anchors.bottomMargin: 46
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image3
        y: 507
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 1M.png"
        anchors.leftMargin: 289
        anchors.bottomMargin: 38
        rotation: 27.022
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image4
        x: 909
        y: 486
        width: 55
        height: 55
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 1k.png"
        anchors.bottomMargin: 59
        rotation: 24.75
        anchors.rightMargin: 60
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image5
        x: 866
        y: 495
        width: 55
        height: 55
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 10.png"
        anchors.bottomMargin: 50
        rotation: 12.428
        anchors.rightMargin: 103
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image7
        x: 898
        y: 526
        width: 55
        height: 55
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 5.png"
        anchors.bottomMargin: 19
        rotation: -26.363
        anchors.rightMargin: 71
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image8
        x: 942
        y: 461
        width: 55
        height: 55
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 500K.png"
        anchors.bottomMargin: 84
        rotation: 16.495
        anchors.rightMargin: 27
        fillMode: Image.PreserveAspectFit
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
            mainStackLayout.currentIndex = 0
        }
    }
}

//    Image {
//        id: image2
//        y: 382
//        width: 55
//        height: 55
//        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 1M.png"
//        anchors.bottomMargin: 103
//        anchors.leftMargin: 250
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image3
//        y: 391
//        width: 55
//        height: 55
//        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 1M.png"
//        anchors.bottomMargin: 94
//        anchors.leftMargin: 292
//        rotation: 27.022
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image4
//        x: 900
//        y: 373
//        width: 55
//        height: 55
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 1k.png"
//        anchors.rightMargin: 49
//        anchors.bottomMargin: 112
//        rotation: 24.75
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image5
//        x: 857
//        y: 382
//        width: 55
//        height: 55
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 10.png"
//        anchors.rightMargin: 92
//        anchors.bottomMargin: 103
//        rotation: 0.56
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image7
//        x: 889
//        y: 413
//        width: 55
//        height: 55
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 5.png"
//        anchors.rightMargin: 60
//        anchors.bottomMargin: 72
//        rotation: -26.363
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image8
//        x: 933
//        y: 348
//        width: 55
//        height: 55
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        source: "../images/Chips/Chip 500K.png"
//        anchors.bottomMargin: 137
//        anchors.rightMargin: 16
//        rotation: 16.495
//        fillMode: Image.PreserveAspectFit
//    }

//    Image {
//        id: image9
//        width: 55
//        height: 55
//        anchors.left: parent.left
//        anchors.top: parent.top
//        source: "../images/Chips/Chip 100k.png"
//        anchors.leftMargin: 393
//        anchors.topMargin: 107
//        rotation: -26.153
//        fillMode: Image.PreserveAspectFit
//    }

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
