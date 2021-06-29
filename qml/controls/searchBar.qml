import QtQuick 2.0

Item {
    FocusScope {
        id: focusScope
        width: 250
        height: 28

        TextArea {
            id: typeSomething
            anchors.fill: parent
            anchors.leftMargin: 8
            verticalAlignment: Text.AlignVCenter
            text: "Type something..."
            color: "gray"
            font.italic: true
            selectByMouse: true
            selectedTextColor: "#ffffff"
            selectionColor: "#ff007f"
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

        Image {
            id: clear
            anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
            source: "images/clear.png"
            opacity: 0

            MouseArea {
                anchors.fill: parent
                onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
            }
        }

        states: State {
            name: "hasText"; when: textInput.text != ''
            PropertyChanges { target: typeSomething; opacity: 0 }
            PropertyChanges { target: clear; opacity: 1 }
        }

        transitions: [
            Transition {
                from: ""; to: "hasText"
                NumberAnimation { exclude: typeSomething; properties: "opacity" }
            },
            Transition {
                from: "hasText"; to: ""
                NumberAnimation { properties: "opacity" }
            }
        ]
    }
}
