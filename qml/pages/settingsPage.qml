import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0
import Qt.labs.animation 1.0

Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

        Rectangle {
            id: rectangleTop
            height: 69
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 40
        }
    }
    Rectangle {
        id: label
        x: 35
        y: 15
        height: 30
        color: "#1d2b49"
        radius: 3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 35
        anchors.leftMargin: 35
        anchors.topMargin: 15
        z: 1

        Label {
            id: label1
            y: 8
            color: "#ffffff"
            text: qsTr("Settings")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            font.pointSize: 12
            antialiasing: false
        }
    }
}
