import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

RoundButton {
    id:btnTopBar
    // Custom Properties
    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnDefaultClr: "#111111"
    property color btnMouseOvertClr: "#23272E"
    property color btnClickClr: "#00a1f1"

    QtObject{
        id: internal
        property var dynClr: if (btnTopBar.down){
                                 btnTopBar.down ? btnClickClr: btnDefaultClr
                             } else {
                                 btnTopBar.hovered ? btnMouseOvertClr: btnDefaultClr
                             }
    }

    radius: 25

    background: Rectangle{
        id:bgBtn
        color: internal.dynClr
        radius: 25
        border.width: 0

        Image {
            id: iconBtn
            source: btnIconSource
            width: 16
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            antialiasing: false
            color: "#ffffff"
        }
    }
}
