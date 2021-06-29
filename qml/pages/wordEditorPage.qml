import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0
import Qt.labs.animation 1.0
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.15

Item {
    Rectangle {
        id: rectangle
        color: "#1a1b15"
        anchors.fill: parent

        Rectangle {
            id: menuBar
            x: 35
            y: 15
            height: 45
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }

        Rectangle {
            id: buttonBar
            x: 41
            y: 9
            height: 25
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: menuBar.bottom
            clip: true
            anchors.leftMargin: 0
            anchors.topMargin: 10
            anchors.rightMargin: 0
        }
    }
    //    Connections{
    //        target: backend
    //                //        function onReadText(text){
    //            //            // Step 4 - text content received from .py file and used to change text here
    //            textEdit.text = text
    //        }
    //    }
}
