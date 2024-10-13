import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12

import "components"

Page {
    id:newGameWindows
    width: 1004
    height: 580
    visible: true
    title: qsTr("New Game")
    background: parent

    //property to clear QMap to empty to run app
    property bool clearQlist: false
    property bool clearQlistQT: myBackend.clearQList(clearQlist)

//    Connections{
//        target: liveImageProvider

//        function onImageChanged() {
//            opencvImage.reload()
//        }
//    }

    Rectangle {
        id: rectangle
        color: "#275121"
        anchors.fill: parent

        Image {
            id: image
            y: 329
            width: 464
            height: 320
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            source: "../images/roulette1.png"
            anchors.leftMargin: 0
            anchors.bottomMargin: -9
            fillMode: Image.PreserveAspectFit
            visible: false
        }
    }

    CustomButton {
        id: newGame_Button
        x: 628
        y: 333
        width: 241
        height: 72
        text: "NEW GAME"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.bold: true
        font.pointSize: 25
        focusPolicy: Qt.WheelFocus
        display: AbstractButton.TextOnly
        colorPressed: "#740303"
        colorMouseOver: "#c80101"
        colorDefault: "#d80000"
        anchors.rightMargin: 135
        anchors.bottomMargin: 135
        onClicked: {
            //clear QMAP to empty
            clearQlist = true
            mainStackLayout.currentIndex = 1
            clearQlist = false
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

    Image {
        id: image91
        width: 55
        height: 55
        visible: false
        anchors.left: parent.left
        anchors.top: parent.top
        source: "../images/Chips/Chip 100k.png"
        anchors.leftMargin: 393
        anchors.topMargin: 107
        rotation: -26.153
        fillMode: Image.PreserveAspectFit
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

//    Image {
//        id: opencvImage
//        property bool counter: false
//        x: 261
//        y: 60
//        width: 574
//        height: 412
//        asynchronous: true
//        source: "image://live/image"
//        cache: false
//        visible: true

//        function reload(){
//            counter = !counter
//            source = "image://live/image?id=" + counter
//        }
//    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
