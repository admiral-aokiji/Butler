import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.15

Item {
    property alias pageCountText: pageCount.text
    property alias fileNameText: fileName.text

    Rectangle {
        id: page
        color: "#15181b"
        border.width: 0
        anchors.fill: parent
        property string pagesNumber: "0"

        Rectangle {
            id: stackContent
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0


            Rectangle {
                id: sideMenu
                width: 150
                color: "#00000000"
                border.color: "#00000000"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 25
                anchors.bottomMargin: 25
                anchors.leftMargin: 25

                Rectangle {
                    id: history
                    height: 40
                    color: "#1f2428"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top

                    Button {
                        id: historyExpand
                        width: 20
                        height: 20
                        text: qsTr(">")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                    }

                    Label {
                        id: historyLabel
                        y: -7
                        width: 100
                        height: 30
                        color: "#ffffff"
                        text: qsTr("Open Recent")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                        font.pointSize: 9
                    }
                }

                Rectangle {
                    id: currentFiles
                    height: 40
                    color: "#1f2428"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: history.bottom
                    anchors.topMargin: 10

                    Label {
                        id: filesOpen
                        y: -7
                        width: 100
                        height: 30
                        color: "#ffffff"
                        text: qsTr("Files open:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                        font.pointSize: 9
                    }
                }

                Button {
                    id: closeAllPdfBtn
                    height: 40
                    text: qsTr("Close All")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    checkable: false
                    anchors.bottomMargin: 100
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    font.pointSize: 9
                    background: Rectangle{
                        color: "#eeeeee"
                        border.width: 0
                    }
                }

                Button {
                    id: openPdfBtn2
                    height: 40
                    text: qsTr("Open Files")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    font.pointSize: 9
                    anchors.bottomMargin: 50
                    background: Rectangle {
                        color: "#eeeeee"
                        border.width: 0
                    }
                    checkable: false
                }

            }


            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: 1
                anchors.bottomMargin: 25
                anchors.leftMargin: 200
                anchors.rightMargin: 35
                anchors.topMargin: 25

                Item{
                    id:openFile
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Rectangle {
                        id: dragFile
                        color: "#1f2428"
                        anchors.fill: parent

                        Item {
                            id: dashedBorder
                            anchors.fill: parent
                            anchors.rightMargin: 20
                            anchors.leftMargin: 20
                            anchors.bottomMargin: 20
                            anchors.topMargin: 20
                            // Use Repeater
                            Label {
                                id: text1
                                height: 26
                                color: "#a8a8a8"
                                text: qsTr("Select File ")
                                anchors.top: parent.top
                                font.pixelSize: 18
                                horizontalAlignment: Text.AlignHCenter
                                anchors.topMargin: 100
                                anchors.horizontalCenter: parent.horizontalCenter
                                minimumPixelSize: 16
                            }

                            Label {
                                id: text2
                                height: 26
                                color: "#a8a8a8"
                                text: qsTr("OR")
                                anchors.top: parent.top
                                font.pixelSize: 18
                                horizontalAlignment: Text.AlignHCenter
                                anchors.topMargin: 70
                                anchors.horizontalCenter: parent.horizontalCenter
                                minimumPixelSize: 16
                            }

                            Label {
                                id: text3
                                height: 26
                                color: "#a8a8a8"
                                text: qsTr("Drag and Drop File")
                                anchors.top: parent.top
                                font.pixelSize: 18
                                horizontalAlignment: Text.AlignHCenter
                                anchors.topMargin: 40
                                anchors.horizontalCenter: parent.horizontalCenter
                                minimumPixelSize: 16
                            }

                        }
                        Button{
                            id: openPdfBtn
                            width: 90
                            height: 40
                            text: "Open File"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: 40
                            font.pointSize: 9
                            anchors.horizontalCenter: parent.horizontalCenter
                            onPressed: {
                                fileOpen.open()
                            }

                            FileDialog{
                                id: fileOpen
                                title: "Open File"
                                folder: shortcuts.home
                                selectMultiple: true
                                nameFilters: ["PDF Files (*.pdf)"]
                                onAccepted: {
                                    // Step 1 - sent URL of file to be opened, openFile is .py function
                                    backend.openPDF(fileOpen.fileUrl)
                                    stackLayout.currentIndex = 1
                                }
                            }
                        }
                    }
                }

                Item {
                    id: openedFile
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Rectangle {
                        id: menuBar
                        height: 120
                        color: "#00000000"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top

                        Item {
                            id: fileInfo
                            height: 40
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.topMargin: 0

                            Label {
                                id: nameLabel
                                width: 80
                                text: qsTr("File Name: ")
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 9
                                color: "#ffffff"
                            }

                            Label {
                                id: fileName
                                width: fileInfo.width - nameLabel.width -savePdfBtn.anchors.rightMargin - 20 -
                                       countLabel.width -closePdfBtn.width - savePdfBtn.width -pageCount.width
                                text: qsTr("---NA---")
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: nameLabel.right
                                verticalAlignment: Text.AlignVCenter
                                anchors.leftMargin: 0
                                font.pointSize: 9
                                color: "#ffffff"
                            }

                            Label {
                                id: countLabel
                                width: 130
                                text:  qsTr("Number of pages: ")
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: pageCount.left
                                verticalAlignment: Text.AlignVCenter
                                anchors.rightMargin: 0
                                font.pointSize: 9
                                color: "#ffffff"
                            }
                            Label {
                                id: pageCount
                                width: 65
                                height: 30
                                color: "#ffffff"
                                text: "0"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: savePdfBtn.left
                                verticalAlignment: Text.AlignVCenter
                                anchors.rightMargin: 20
                                font.pointSize: 9
                            }

                            ResourceBtn{
                                id:closePdfBtn
                                width: 30
                                text: qsTr("X")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                btnDefaultClr: "#e60000"
                            }

                            ResourceBtn {
                                id: savePdfBtn
                                width: 30
                                text: qsTr("S")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: closePdfBtn.left
                                anchors.rightMargin: 7
                                btnDefaultClr: "#00e604"
                            }
                        }

                        Item {
                            id: rangeSelect
                            height: 80
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: fileInfo.bottom
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.topMargin: 0


                            Label {
                                id: rangeLabel
                                width: 90
                                height: 40
                                color: "#ffffff"
                                text: "Page Range:"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                font.pointSize: 9
                                anchors.leftMargin: 0
                            }

                            TextInput {
                                id: rangeInput
                                width: 220
                                height: 40
                                font.pointSize: 9
                                color: "#ffffff"
                                anchors.left: rangeLabel.right
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                anchors.leftMargin: 10
                                text: qsTr("---NA---")
                            }
                            Switch {
                                id: rangeSwitch
                                width: 65
                                text: qsTr("Switch")
                                anchors.left: rangeInput.right
                                anchors.top: parent.top
                                anchors.topMargin: 0
                                anchors.leftMargin: 5
                                checked: false
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 68
                                onToggled: {
                                    if (rangeSwitch.checked) {
                                        rangeInput.text = finalPageRange.text
                                        switchStatus.text = "Include"
                                    }
                                    else switchStatus.text = "Exclude"
                                }
                            }
                            Label {
                                id: switchStatus
                                width: 60
                                height: 40
                                color: "#ffffff"
                                text: "Exclude"
                                anchors.left: rangeSwitch.right
                                verticalAlignment: Text.AlignVCenter
                                anchors.leftMargin: 5
                                font.pointSize: 9
                            }
                            Label {
                                id: pagesToKeep
                                width: 110
                                height: 40
                                color: "#ffffff"
                                text: "Pages to Keep:"
                                anchors.right: finalPageRange.left
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                anchors.rightMargin: 0
                                font.pointSize: 9
                            }

                            Label {
                                id: finalPageRange
                                width: 250
                                height: 80
                                color: "#ffffff"
                                text: "---NA---"
                                anchors.right: parent.right
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignTop
                                wrapMode: Text.WordWrap
                                topPadding: 11
                                anchors.topMargin: 0
                                anchors.rightMargin: 0
                                font.pointSize: 9
                            }

                            Item {
                                id: viewTile
                                width: 450
                                height: 40
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0

                                ResourceBtn {
                                    id: thumbnailBtn
                                    width: 30
                                    text: qsTr("S")
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    btnDefaultClr: "#00e604"
                                }

                                ResourceBtn {
                                    id: scrollPdfBtn
                                    width: 30
                                    text: qsTr("S")
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: thumbnailBtn.right
                                    anchors.leftMargin: 10
                                    btnDefaultClr: "#00e604"
                                }

                                ResourceBtn {
                                    id: fullScreenBtn
                                    width: 30
                                    text: qsTr("S")
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: scrollPdfBtn.right
                                    anchors.leftMargin: 10
                                    btnDefaultClr: "#00e604"
                                }
                            }



                        }
                    }

                    Rectangle {
                        id: pdfDisplay
                        color: "#00000000"
                        border.color: "#252e39"
                        border.width: 3
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: menuBar.bottom
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 10
                    }
                }
            }
        }
    }
    Connections{
        target: backend
        function onPdfPages(pages){
            pageCountText = pages
            if (pages ===1) {
                finalPageRange.text = '1'
                // Convert rangeInput to Label so that user cannot delete page
                rangeInput.text = '--'
            }
            finalPageRange.text = '1 - ' + pages
            rangeInput.text = '--'
        }
        function onReadFileName(file){
            fileNameText = file
        }

        function onThumbNails(imgList){

            let component = Qt.createComponent("../controls/pageThumbNail.qml")
//            loop should run for width//thumbnail width times and another function for resizing of windows where they are created again
            for (var i =0; i < imgList.length - 2; i++){
                let pos = 30 + 160*i
                let pageNo = i +1
                let imgsource = "../../images/pdfEditor/thumbnails/page-"+ pageNo + ".png"

                function finishCreation() {
                    if (component.status === Component.Ready) {
                        // Changing Y for wrapping
                        if (pos < stackLayout.width) console.log(stackLayout.width, pageNo)
                        var wind = component.createObject(pdfDisplay,{imageSource: imgsource, leftMarg: pos, pdfPageNo: pageNo});
                        if (wind === null) console.log("Error creating object")
                            // Error Handling
                    } else if (component.status === Component.Error) {
                        // Error Handling
                        console.log("Error loading component: ", component.errorString());
                    }
                }

                if (component.status === Component.Ready){
                    console.log("Page " + pageNo + " thumbnail generated")
                    finishCreation();
                }
                else {
                    console.log("Not Reached")
                    component.statusChanged.connect(finishCreation);
                }
            }

        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:700;width:1050}D{i:28;invisible:true}
}
##^##*/
