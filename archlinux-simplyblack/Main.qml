/***********************************************************************/


import QtQuick 2.0

import SddmComponents 2.0


Rectangle {
    width: 640
    height: 480

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "steelblue"
            errorMessage.text = textConstants.loginSucceeded
        }

        onLoginFailed: {
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            source: config.background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    Rectangle {
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        color: "transparent"
        transformOrigin: Item.Top

        Image {
            id: archlinux
            width: height * 3
            height: parent.height / 6
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -1 * height / 2
            anchors.horizontalCenterOffset: 0
            fillMode: Image.PreserveAspectFit
            transformOrigin: Item.Center
            source: "archlinux.png"
        }

        Rectangle {
            anchors.centerIn: parent
            height: Math.max(parent.height / 3.75, mainColumn.implicitHeight + 40)
            width: Math.max(height * 2, mainColumn.implicitWidth + 40)
            anchors.verticalCenterOffset: Math.max(height * 0.75, mainColumn.implicitHeight * 0.75)
            color: "#0C0C0C"

            Column {
                id: mainColumn
                anchors.centerIn: parent
                width: parent.width * 0.9
                spacing: 12

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    width: parent.width
                    height: text.implicitHeight
                    color: "white"
                    text: textConstants.welcomeText.arg(sddm.hostName)
                    wrapMode: Text.WordWrap
                    font.pixelSize: 24
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }

                Row {
                    width: parent.width
                    spacing: 4
                    Text {
                        id: lblName
                        width: parent.width * 0.20; height: 30
                        color: "white"
                        text: textConstants.userName
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        font.pixelSize: 12
                    }

                    TextBox {
                        id: name
                        width: parent.width * 0.8; height: 30
                        text: userModel.lastUser
                        font.pixelSize: 14

                        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    width: parent.width
                    spacing : 4
                    Text {
                        id: lblPassword
                        width: parent.width * 0.2; height: 30
                        color: "white"
                        text: textConstants.password
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        font.pixelSize: 12
                    }

                    PasswordBox {
                        id: password
                        width: parent.width * 0.8; height: 30
                        font.pixelSize: 14
                        tooltipBG: "lightgrey"

                        // This hack courtesy of our friends at KDE: https://quickgit.kde.org/?p=plasma-workspace.git&a=blobdiff&h=275801dc5539a342276e4c9f6817ff3c80f7d020&hp=31423628c9a847344c0e3e27b98b73b6042cefe6&hb=dfc4b8b2a0e2b012f68f0192e29081ee230e8c03&f=lookandfeel%2Fcontents%2Floginmanager%2FMain.qml
                        // focus works in qmlscene
                        // but this seems to be needed when loaded from SDDM
                        // I don't understand why, but we have seen this before in the old lock screen
                        focus: true
                        Timer {
                            interval: 200
                            running: true
                            onTriggered: password.forceActiveFocus()
                        }

                        KeyNavigation.backtab: name; KeyNavigation.tab: session

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    spacing: 4
                    width: parent.width / 2
                    z: 100

                    Row {
                        z: 100
                        width: parent.width * 1.2
                        spacing : 4
                        anchors.bottom: parent.bottom

                        Text {
                            id: lblSession
                            width: parent.width / 3; height: 30
                            text: textConstants.session
                            verticalAlignment: Text.AlignVCenter
                            color: "white"
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                        }

                        ComboBox {
                            id: session
                            width: parent.width * 2 / 3; height: 30

                            arrowIcon: "angle-down.png"

                            model: sessionModel
                            index: sessionModel.lastIndex

                            KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                        }
                    }
                    Row {
                        z: 101
                        width: parent.width * 0.8
                        spacing : 10
                        anchors.bottom: parent.bottom

                        Text {
                            id: lblLayout
                            width: parent.width / 3; height: 30
                            text: textConstants.layout
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                        }

                        LayoutBox {
                            id: layoutBox
                            width: (parent.width * 2 / 3) -10; height: 30

                            arrowIcon: "angle-down.png"

                            KeyNavigation.backtab: session; KeyNavigation.tab: loginButton
                        }
                    }
                }

                Column {
                    width: parent.width
                    Text {
                        id: errorMessage
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: textConstants.prompt
                        color: "white"
                        font.pixelSize: 12
                    }
                }

                Row {
                    spacing: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, 80) + 8
                    Button {
                        id: loginButton
                        text: textConstants.login
                        width: parent.btnWidth
                        color: "#1793d1"

                        onClicked: sddm.login(name.text, password.text, session.index)

                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                    }

                    Button {
                        id: shutdownButton
                        text: textConstants.shutdown
                        width: parent.btnWidth
                        color: "#1793d1"

                        onClicked: sddm.powerOff()

                        KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                    }

                    Button {
                        id: rebootButton
                        text: textConstants.reboot
                        width: parent.btnWidth
                        color: "#1793d1"

                        onClicked: sddm.reboot()

                        KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
