import QtQuick 2.0
import QtGraphicalEffects 1.12

Item{

    width: 580
    height: 380

    Rectangle {
        id: rectangle2
        x: 10
        y: 0
        width: 570
        height: 380
        color: "#996515"
        radius: 190
        border.color: "#f7e275"
        border.width: 10
        RadialGradient{
            horizontalRadius: 300
            horizontalOffset: 40
            anchors.fill: parent
            anchors.rightMargin: 95
            anchors.bottomMargin: 14
            anchors.topMargin: 14
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#fbc8923e" }
                GradientStop { position: 0.6; color: "#996515" }
                GradientStop { position: 0.7; color: "#00000000" }
                GradientStop { position: 1; color: "#00000000" }
            }
        }
    }

    //    Rectangle {
    //        id: rectangle4
    //        x: -10
    //        y: 73
    //        width: 335
    //        height: 357
    //        color: "#00000000"
    //        radius:184
    //        border.color: "#00000000"
    //        RadialGradient{
    //            anchors.fill: parent
    //            anchors.rightMargin: 16
    //            gradient: Gradient {
    //                GradientStop { position: 0.0; color: "#fbc8923e" }
    //                GradientStop { position: 0.8; color: "#996515" }
    //            }
    //        }

    //    }

    Image {
        id: image2
        x: 217
        y: 40
        width: 320
        height: 300
        source: "../../images/Roulette 4.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: rectangle1
        y: 1
        width: 10
        height: 378
        color: "#f7e275"
        border.color: "#f7e275"
        anchors.left: parent.left
        anchors.leftMargin: 190
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
