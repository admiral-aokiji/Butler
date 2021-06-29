import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"

Window {
    id: mainWindow
    width: 1200
    height: 800
    minimumWidth: 1200
    minimumHeight: 800
    visible: true
    color: "#00000000"
    title: qsTr("Butler")

    // Remove title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowStatus: 0
    // 1 if maximized else 0
    property int windowMargin: 10
    property alias activePage: stackView.currentItem
    QtObject{
        id: internal

        function resetResizeBorders(){
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                btnMaximize.btnIconSource = "../images/svg_images/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                internal.resetResizeBorders()
                btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                internal.resetResizeBorders()
                btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            internal.resetResizeBorders()
            btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
        }

        function activateMenu(btn){
            pdfBtn.isActiveMenu = false
            resBtn.isActiveMenu = false
            pwdDbBtn.isActiveMenu = false
            wordEditorBtn.isActiveMenu = false
            homeBtn.isActiveMenu = false
            settingsBtn.isActiveMenu = false
            btn.isActiveMenu =true
            labelTopDesc.text = btn.text
            topBarDesc.color = btn.activeMenuLColor
        }
    }

    Rectangle {
        id: bg
        color: "#212b27"
        border.color: "#1f2522"
        border.width: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 80
                color: "#111111"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleBtn{
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDesc
                    height: 33
                    color: "#0dd43a"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 80
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopDesc
                        color: "#000000"
                        text: qsTr("Welcome to Aokiji's Dev Centre")
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 7
                        leftPadding: 10
                        font.family: "Verdana"
                        anchors.leftMargin: 0
                        anchors.rightMargin: 300
                    }

                    Label {
                        id: labelTopRight
                        color: "#80868c"
                        text: qsTr("")
                        anchors.left: labelTopDesc.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        rightPadding: 10
                        font.pointSize: 9
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 47
                    color: "#00000000"
                    border.width: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 80
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }
                    Image {
                        id: iconApp
                        width: 24
                        height: 24
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: titleBarText
                        color: "#dedfe0"
                        text: qsTr("B U T L E R")
                        anchors.left: iconApp.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.ExtraLight
                        font.pointSize: 12
                        font.family: "Verdana"
                        anchors.leftMargin: 10
                    }
                }

                Row {
                    id: windowBtns
                    height: 41
                    width: 78
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarBtn{
                        id: btnMinimize
                        anchors.verticalCenter: parent.verticalCenter
                        btnMouseOvertClr: "#55d81f"
                        padding: 13
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarBtn {
                        id: btnMaximize
                        btnMouseOvertClr: "#c3c01a"
                        padding: 13
                        anchors.verticalCenter: parent.verticalCenter
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarBtn {
                        id: btnClose
                        btnMouseOvertClr: "#ff0000"
                        btnClickClr: "#ff0000"
                        padding: 13
                        anchors.verticalCenter: parent.verticalCenter
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 80
                    color: "#111111"
                    border.color: "#0f1311"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    clip: true

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width === 80) return 250; else return 80
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }


                    Column {
                        id: column
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        //                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        //                        anchors.bottomMargin: 90

                        LeftMenuBtn{
                            id: homeBtn
                            width: leftMenu.width
                            text: qsTr("Home")
                            activeMenuLColor: "#0dd43a"
                            isActiveMenu: true
                            onClicked: {
                                internal.activateMenu(homeBtn)
                                stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: resBtn
                            btnIconSource: "../images/svg_images/open_icon.svg"
                            width: leftMenu.width
                            text: qsTr("Resource Opener")
                            activeMenuLColor: "#d40d0d"
                            onClicked: {
                                internal.activateMenu(resBtn)
                                stackView.push(Qt.resolvedUrl("pages/resourcePage.qml"))
                                backend.loadSections('json/folders.json')
                            }
                        }

                        LeftMenuBtn {
                            id: pdfBtn
                            btnIconSource: "../images/svg_images/save_icon.svg"
                            width: leftMenu.width
                            text: "PDF Editor"
                            activeMenuLColor:"#0d6dd4"
                            onClicked: {
                                internal.activateMenu(pdfBtn)
                                stackView.push(Qt.resolvedUrl("pages/pdfEditorPage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: pwdDbBtn
                            width: leftMenu.width
                            text: "Password DB"
                            btnIconSource: "../images/svg_images/save_icon.svg"
                            activeMenuLColor: "#aed40d"
                            onClicked: {
                                internal.activateMenu(pwdDbBtn)
                                stackView.push(Qt.resolvedUrl("pages/pwdDbPage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: wordEditorBtn
                            width: leftMenu.width
                            text: "Question Paper Typer"
                            btnIconSource: "../images/svg_images/save_icon.svg"
                            activeMenuLColor: "#d40db2"
                            onClicked: {
                                internal.activateMenu(wordEditorBtn)
                                stackView.push(Qt.resolvedUrl("pages/wordEditorPage.qml"))
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: settingsBtn
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        activeMenuLColor: "#eaeaea"
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            internal.activateMenu(settingsBtn)
                            stackView.push(Qt.resolvedUrl("pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPage
                    color: "#00000000"
                    border.width: 0
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0
                    clip: true

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: Qt.resolvedUrl("pages/homePage.qml")
                    }
                }

                Rectangle {
                    id: bottomBar
                    color: "#19211e"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPage.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0

                    Label {
                        id: labelBottomDesc
                        color: "#868686"
                        text: qsTr("----------")
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                        anchors.leftMargin: 0
                        anchors.rightMargin: 30
                        font.family: "Verdana"
                        font.pointSize: 8
                    }
                    MouseArea {
                        id: resizeWindow
                        width: 30
                        height: 30
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if (active){
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }
                        Image {
                            id: resizeImage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                            opacity: 0.5
                        }
                    }
                }
            }
        }
    }

    DropShadow{
        x: 10
        y: 10
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }
    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }
    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 30
        anchors.topMargin: 30
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 30
        anchors.leftMargin: 30
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }
}
