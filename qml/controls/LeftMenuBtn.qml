import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnLeftMenu
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnDefaultClr: "#111111"
    property color btnMouseOverClr: "#23272E"
    property color btnClickClr: "#00a1f1"
    property int iconWidth: 20
    property int iconHeight: 20
    property color activeMenuLColor: "#008856"
    property color activeMenuRColor: "#2c313c"
    property bool isActiveMenu: false

    QtObject{
        id: internal

        property var dynColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? btnClickClr : btnDefaultClr
                                   } else {
                                       btnLeftMenu.hovered ? btnMouseOverClr : btnDefaultClr
                                   }

    }

    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynColor

        Rectangle{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuLColor
            width: 3
            visible: isActiveMenu
        }

        Rectangle{
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuRColor
            width: 5
            visible: isActiveMenu
        }

    }

    contentItem: Item{
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 28
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text{
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
        }
    }
}
