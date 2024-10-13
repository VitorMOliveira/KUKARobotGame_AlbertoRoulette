import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button1
    width: parent.width
    height: parent.height
    // Custom Properties
    property color colorDefault: "#F00000"

    property bool crossVisible

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
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: rectangle1
            width: (parent.width)-4
            height: (parent.height)-4
            color: colorDefault
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: cross
                width: (parent.width)-4
                height: (parent.height)-4
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/cross2.png"
                visible: crossVisible
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    onClicked: visibility()
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
