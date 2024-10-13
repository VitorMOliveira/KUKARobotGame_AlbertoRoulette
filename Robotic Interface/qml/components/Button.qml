import QtQuick 2.0

MouseArea {
    x:0
    y:0
    width: 150
    height: 50

    property var textButton

    Text {
        id: textButton1
        text: "textButton"
    }
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#ffffff"

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1639FF" }
            GradientStop { position: 0.020; color: "white" }
            GradientStop { position: 1.0; color: "#1639FF" }
        }
    }
}
