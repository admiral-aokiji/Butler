import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id:btnToggle
    // Custom Properties
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnDefaultClr: "#111111"
    property color btnMouseOvertClr: "#222222"
    property color btnClickClr: "#f11100"

    QtObject{
        id: internal
        property var dynClr: if (btnToggle.down){
                                 btnToggle.down ? btnClickClr: btnDefaultClr
                             } else {
                                 btnToggle.hovered ? btnMouseOvertClr: btnDefaultClr
                             }
    }

    implicitHeight: 80
    implicitWidth: 80

    background: Rectangle{
        id:bgBtn
        color: internal.dynClr

        Image {
            id: iconBtn
            source: btnIconSource
            width: 25
            height: 25
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



/*##^##
Designer {
    D{i:0;height:70;width:70}
}
##^##*/
