import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id:btnResources
    // Custom Properties
    property color btnDefaultClr: "#e6e200"
    property color btnMouseOvertClr: "#888888"
    property color btnClickClr: "#ffffff"

    QtObject{
        id: internal
        property var dynClr: if (btnResources.down){
                                 btnResources.down ? btnClickClr: btnDefaultClr
                             } else {
                                 btnResources.hovered ? btnMouseOvertClr: btnDefaultClr
                             }
    }

    implicitHeight: 30
    implicitWidth: 80
    text: qsTr("Function")
    font.pointSize: 9
    display: AbstractButton.TextOnly

    background: Rectangle{
        color: internal.dynClr
        radius: 5
        border.width: 0
    }
}

/*##^##
Designer {
    D{i:0;height:80;width:80}
}
##^##*/
