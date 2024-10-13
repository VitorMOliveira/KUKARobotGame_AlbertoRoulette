import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"

Page {
    id: playernWindow
    y:50
    width: 1024
    height: 600
    visible: true
    title: qsTr("PLAYERS")

    Rectangle {
        id: rectangle
        color: "#fff000"
        anchors.fill: parent

        TableNumbers {
            id: tableNumbers
            x: 388
            y: 143
        }
    }

    CustomButton {
        id: return_Button
        x: 874
        y: 536
        width: 150
        height: 64
        text: "RETURN 4 Players"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        onClicked: {
            mainStackLayout.currentIndex=0
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
