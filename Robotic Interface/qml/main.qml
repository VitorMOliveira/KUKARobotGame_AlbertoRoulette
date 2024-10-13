import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import "components"

Window {
    id:mainWindow
    width: 1024
    height: 600
    visible: true
    screen: Qt.application.screens[1]
    //    visibility: "FullScreen"
    title: qsTr("Robotic Interface")
    color: "#275121"

    Connections{
        target: liveImageProvider

        function onImageChanged() {
            opencvImage.reload()
        }
    }

    Timer {
        id: timer
    }

    //delay
    function delay(delayTime,cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }


    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#275121"
        border.color: "#f7e275"
        border.width: 10
    }

    StackLayout{
        id: mainStackLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 50

        Loader {
            id:loadermachine
            source: "qrc:/qml/NewGame.qml"
        }
        Players{}
        SelectNumbersShots{}
        TwoPlayers{}
        FourPlayers{}
    }

    CustomButton {
        id: btnConfirm
        x: parent.width-10
        width: 25
        height: 25
        opacity: 1
        text: "X"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 20
        font.bold: true
        font.pointSize: 12
        colorPressed: "#ea1043"
        colorMouseOver: "#bc0c35"
        colorDefault: "#ea1043"
        onClicked: {
            Qt.quit()
        }
    }

    Roulette{
        height: 380
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: -190
        anchors.rightMargin: 634
    }

    Image {
        id: image2
        y: 489
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 1M.png"
        anchors.bottomMargin: 56
        anchors.leftMargin: 247
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Image {
        id: image3
        y: 498
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "../images/Chips/Chip 1M.png"
        anchors.bottomMargin: 47
        anchors.leftMargin: 289
        rotation: 27.022
        fillMode: Image.PreserveAspectFit
        visible: false
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
        anchors.rightMargin: 60
        anchors.bottomMargin: 59
        rotation: 24.75
        fillMode: Image.PreserveAspectFit
        visible: false
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
        anchors.rightMargin: 103
        anchors.bottomMargin: 50
        rotation: 12.428
        fillMode: Image.PreserveAspectFit
        visible: false
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
        anchors.rightMargin: 71
        anchors.bottomMargin: 19
        rotation: -26.363
        fillMode: Image.PreserveAspectFit
        visible: false
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
        anchors.rightMargin: 27
        rotation: 16.495
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Image {
        id: image9
        width: 55
        height: 55
        anchors.left: parent.left
        anchors.top: parent.top
        source: "../images/Chips/Chip 100k.png"
        anchors.leftMargin: 393
        anchors.topMargin: 107
        rotation: -26.153
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Rectangle{
        id: rectangle2
        x: 479
        y: 131
        width: 450
        height: 340
        border.color: "#f7e275"
        border.width: 5
        visible: false

        Image {
            id: opencvImage
            property bool counter: false
            asynchronous: true
            source: "image://live/image"
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            cache: false
            visible: true
            anchors.fill: parent

            function reload(){
                rectangle2.visible = true
                counter = !counter
                source = "image://live/image?id=" + counter

                delay(3000, function() {
                    rectangle2.visible = false
                })
            }
        }
    }

    CustomButton {
        id: buttonBuzzer
        x: 42
        y: 532
        width: 20
        height: 20
        text: " "
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        colorPressed: "#00ffffff"
        colorMouseOver: "#00ffffff"
        colorDefault: "#00ffffff"
        anchors.bottomMargin: 15
        anchors.rightMargin: 15
        enabled: true

        onClicked: {
            if(image79.visible === true){
                image79.visible = false
                myBackend.writeSound("1")
            } else if(image79.visible === false){
                image79.visible = true
                myBackend.writeSound("0")
            }
        }

        Image {
            id: image78
            anchors.fill: parent
            source: "qrc:/images/SoundIcon.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image79
            source: "qrc:/images/cross.png"
            visible: false
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:23}D{i:21}
}
##^##*/
