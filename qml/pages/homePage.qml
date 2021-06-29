import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0

Item {
    Rectangle {
        id: rectangle
        color: "#151b17"
        anchors.fill: parent
        implicitHeight: 800
        implicitWidth: 800

        Rectangle {
            id: rectangleTop
            height: 40
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 35
            anchors.leftMargin: 35
            anchors.topMargin: 10

            FocusScope {
                id: focusScope
                width: 250; height: 28

//                BorderImage {
//                    source: "images/lineedit-bg.png"
//                    width: parent.width; height: parent.height
//                    border { left: 4; top: 4; right: 4; bottom: 4 }
//                }

//                BorderImage {
//                    source: "images/lineedit-bg-focus.png"
//                    width: parent.width; height: parent.height
//                    border { left: 4; top: 4; right: 4; bottom: 4 }
//                    visible: parent.activeFocus ? true : false
//                }

                Text {
                    id: typeSomething
                    anchors.fill: parent; anchors.leftMargin: 8
                    verticalAlignment: Text.AlignVCenter
                    text: "Type something..."
                    color: "gray"
                    font.italic: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
                }

                TextInput {
                    id: textInput
                    height: 40
                    anchors.top: parent.top
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 0
                    font.pointSize: 14
                    anchors { left: parent.left; leftMargin: 0 }
                    focus: true
                    selectByMouse: true
                }

//                Image {
//                    id: clear
//                    anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
//                    source: "images/clear.png"
//                    opacity: 0

//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
//                    }
//                }

//                states: State {
//                    name: "hasText"; when: textInput.text != ''
//                    PropertyChanges { target: typeSomething; opacity: 0 }
//                    PropertyChanges { target: clear; opacity: 1 }
//                }

//                transitions: [
//                    Transition {
//                        from: ""; to: "hasText"
//                        NumberAnimation { exclude: typeSomething; properties: "opacity" }
//                    },
//                    Transition {
//                        from: "hasText"; to: ""
//                        NumberAnimation { properties: "opacity" }
//                    }
//                ]
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:960}
}
##^##*/
