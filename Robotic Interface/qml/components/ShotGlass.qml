import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button
    width: 67
    height: 89
    enabled: enableCross

    property color colorDefault: "#F00000"
    property string imageSource
    property string crossInvisible
    property bool crossVisible
    property bool enableCross

    Connections{
        target: myBackend

        //Function to clear cross when has press Clear Button
        function onCrossInvisible(crossInvisible) {
            enabled = true
            cross.visible = crossInvisible
        }
    }

    //Function to show cross when press glass
    function visibility() {
        if(cross.visible===false){
            cross.visible=true
            crossVisible = true
        } else {
            cross.visible=false
            crossVisible = false
        }
    }

    Rectangle{
        id: rectangle
        height: parent.height
        width: parent.width
        color: "#275121"
        border.color: "#275121"
        border.width: 2

        Image {
            id: name
            x: 0
            y: 0
            width: 67
            height: 89
            anchors.verticalCenter: parent.verticalCenter
            source: imageSource
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    Image {
        id: cross
        x: 8
        y: 13
        width: 67
        height: 90
        source: "qrc:/images/cross2.png"
        layer.smooth: false
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        //visible: crossVisible
        visible: true
        anchors.verticalCenter: parent.verticalCenter
    }

    ColorOverlay {
        anchors.fill: bug
        source: bug
        color: "#1f96e6"  // make image like it lays under red glass
    }

//    background: Rectangle{
//        color: internal.dynamicColor
//    }

    onClicked: {
        visibility()
    }

    onCrossVisibleChanged: {
        cross.visible = true
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
