import QtQuick 2.0
Rectangle{
    property alias leftMarg: tnContainer.anchors.leftMargin
    property alias imageSource: tnImg.source
    property alias pdfPageNo: pdfPageNo.text

    id: tnContainer
    width: 140
    height: 210
    color: "#00000000"
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 30
    anchors.topMargin: 10

    Text{
        id: pdfPageNo
        color: "#ffffff"
        text: "Page Number"
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 2
    }

    Rectangle {
        id: tn
        color: "#ffffff"
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 20
        anchors.topMargin: 5

        Image {
            id: tnImg
            anchors.fill: parent
            source: imageSource
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectFit
        }
    }
}
