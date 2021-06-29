import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../controls"
import QtQuick.Dialogs 1.3

Item {
    property string folderPath: pathOpen.fileUrl
    Rectangle {
        id: pageBg
        color: "#1b1515"
        anchors.fill: parent

        Rectangle {
            id: searchBar
            x: 35
            y: 15
            height: 30
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            Rectangle {
                id: searchBox
                height: 30
                color: "#495163"
                radius: 10
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 280
                anchors.leftMargin: 50
                anchors.topMargin: 0
                TextField {
                    id: topicName
                    placeholderText: "Type something"
                    color: "#e1d9d9"
                    onFocusChanged: topicName.placeholderText = ''
                    anchors.fill: parent
                    background: Rectangle {
                        color: "#00000000"
                    }
                    selectByMouse: true
                    selectedTextColor: "#FFFFFF"
                    selectionColor: "#ff007f"
                    placeholderTextColor: "#e1d9d9"
                    Keys.onEnterPressed: {
                        //confirmation box DialogButtonBox
                    }
                    Keys.onTabPressed: {
                        addPathBtn.onPressed()
                    }
                }
            }
            ResourceBtn{
                id: addPathBtn
                width: 100
                height: 25
                text: qsTr("Add Local Path")
                anchors.right: addNewBtn.left
                anchors.top: parent.top
                btnDefaultClr: "#fdfdda"
                font.pointSize: 8
                anchors.rightMargin: 20
                anchors.topMargin: 0
                onPressed: {
                    pathOpen.open()
                }
                FileDialog{
                    id: pathOpen
                    title: "Select Folder"
                    folder: shortcuts.home
                    selectFolder: true
//                    favoriteFolders: ''
                    onAccepted: {
                        console.log(pathOpen.fileUrl)
                        console.log(folderPath)
                        //export to some property
                    }
                }
            }
            ResourceBtn{
                id: addNewBtn
                height: 25
                text: qsTr("Add New")
                anchors.right: parent.right
                anchors.top: parent.top
                font.pointSize: 8
                anchors.rightMargin: 50
                anchors.topMargin: 0
                onPressed: {
                    console.log(topicName.text, pathOpen.fileUrl.toString().slice(8))
                    backend.addSection(topicName.text, pathOpen.fileUrl.toString().slice(8))
                    backend.loadSections('json/folders.json')
                }
            }
        }

        Rectangle {
            id: topicBox
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: searchBar.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.leftMargin: 30
            anchors.topMargin: 20
            anchors.rightMargin: 30

            Component {
                id: resComp
                Item{
                    id: itemRow
                    height: 40
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    Text {
                        width: Math.max(150,parent.width/4)
                        color: "#ffffff"
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    ResourceBtn {
                        width: 100
                        text: qsTr('Open Folder')
                        font.pointSize: 8
                        height: 30
                        anchors.right: parent.right
                        anchors.rightMargin: 220
                        onPressed: backend.openFolder(folderPath)
                    }
                    ResourceBtn {
                        width: 100
                        text: qsTr('Detailed View')
                        btnDefaultClr: "#08e600"
                        font.pointSize: 8
                        height: 30
                        anchors.right: parent.right
                        anchors.rightMargin: 100
                        //                        TreeView {
                        //            TableViewColumn {
                        //                title: "Name"
                        //                role: "fileName"
                        //                width: 300
                        //            }
                        //            TableViewColumn {
                        //                title: "Permissions"
                        //                role: "filePermissions"
                        //                width: 100
                        //            }
                        //            model: fileSystemModel
                        //        }
                        //          QFileSystemModel *model = new QFileSystemModel;
                        //            model->setRootPath(QDir::currentPath());
                        //                        onPressed: backend.openPDF('E:/Technologies')
                    }
                    ResourceBtn {
                        width: 60
                        text: qsTr('Delete')
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        btnDefaultClr: "#ec0606"
                        font.pointSize: 8
                        height: 30
                        //                        onPressed: backend.openPDF('E:/Technologies')
                    }
                }
            }

            ListModel {
                id: resTopicMod
            }

            ListView {
                id: listView
                x: 0
                y: 0
                anchors.fill: parent
                model: resTopicMod
                delegate: resComp
                ScrollBar.vertical: ScrollBar{}
            }

        }
    }
    WorkerScript{
        id: worker
        source: '../../js/dataloader.mjs'
    }

    Connections{
        target: backend
        function onAddTopic(jsontxt){
            var msg = {'action': 'appendItem', 'model': listView.model, 'data':JSON.parse(jsontxt).objects}
            worker.sendMessage(msg)
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
