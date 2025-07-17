import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: messageContainer
    width: 450
    height: 350
    color: "transparent"
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "#99000000"
    }

    property var messageCompData :{
        "messageData" : {
            "orderMessageAlert":{
                weaponAlert : true,
                airRaidWarning: false,
                radiationAlert : [
                    {radarAlert : true},
                    {sonarAlert: true},
                    {communicationAlert:true}
                ]
            },
            "engageMessageAlert" : {
                weaponAlert : false,
                airRaidWarning: false,
                radiationAlert : [
                    {radarAlert : true},
                    {sonarAlert: false},
                    {communicationAlert:true}
                ]
            },
            "shortMessageAlert":{
                weaponAlert : false,
                airRaidWarning: false,
                radiationAlert : [
                    {radarAlert : true},
                    {sonarAlert: true },
                    {communicationAlert:false}
                ]
            }
        }
    }

    Rectangle {
        id: messagePanel
        width: 450
        height: 350
        anchors.centerIn: parent
        color: "transparent"

        // Header
        RowLayout {
            width: parent.width
            height: 50

            Label {
                text: "Machine"
                font.pixelSize: 20
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignLeft
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: "✕"
                font.pixelSize: 16
                color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: messageContainer.visible = false
                }
            }
        }

        // Custom tab bar
        Item {
            id: customTabBar
            width: parent.width
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 50
            property int currentIndex: 0

            Row {
                spacing: 0
                anchors.fill: parent

                Repeater {
                    model: ["ORDER", "ENGAGEMENT", "SHORT"]
                    delegate: Item {
                        width: customTabBar.width / 3
                        height: parent.height

                        Label {
                            text: modelData
                            color: customTabBar.currentIndex === index ? "#7FFF00" : "white"
                            font.pixelSize: 14
                            anchors.centerIn: parent
                        }

                        Rectangle {
                            visible: customTabBar.currentIndex === index
                            height: 2
                            width: parent.width / 2
                            color: "#7FFF00"
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: customTabBar.currentIndex = index
                        }
                    }
                }
            }
        }

        // Tab content loader
        Loader {
            id: tabContentLoader
            anchors.top: customTabBar.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            sourceComponent: dynamicTabComponent

            property var currentTabData: {
                switch(customTabBar.currentIndex) {
                    case 0: return messageCompData.messageData.orderMessageAlert;
                    case 1: return messageCompData.messageData.engageMessageAlert;
                    case 2: return messageCompData.messageData.shortMessageAlert;
                    default: return messageCompData.messageData.orderMessageAlert;
                }
            }
        }

        // ----------- Dynamic Tab Component -----------
        Component {
            id: dynamicTabComponent

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                property var messageMap: ({
                                              "1": ["11:41:51", "12:42:52"],
                                              "2": ["12:34:56", "09:18:27"]
                                          })

                ComboBox {
                    id: machineSelector
                    width: parent.width
                    model: Object.keys(messageMap)
                    currentIndex: -1
                    displayText: currentIndex >= 0 ? currentText : "SELECT NU NUMBER"

                    background: Rectangle {
                        color: "#66ffffff"
                        border.color: "#555"
                    }
                    contentItem: Text {
                        text: machineSelector.displayText
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 35
                    color: "#444"
                    border.color: "#666"
                    visible: machineSelector.currentIndex >= 0

                    MouseArea {
                        anchors.fill: parent
                        onClicked: machineSelector.currentIndex = -1
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Label {
                            text: "← Back"
                            color: "white"
                            Layout.fillWidth: true
                        }
                    }
                }

                ListView {
                    width: parent.width
                    height: 200
                    spacing: 4
                    visible: machineSelector.currentIndex >= 0
                    model: machineSelector.currentIndex >= 0 ? messageMap[machineSelector.currentText] : []
                    delegate: Column {
                        width: parent.width
                        property bool expanded: false

                        Rectangle {
                            width: parent.width
                            height: 40
                            color: "#333"
                            border.color: "#555"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: parent.parent.expanded = !parent.parent.expanded
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 20

                                Label {
                                    text: modelData
                                    color: "white"
                                    Layout.fillWidth: true
                                }

                                Label {
                                    text: parent.parent.parent.expanded ? "▲" : "▼"
                                    color: "white"
                                }
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: 4
                            visible: parent.expanded

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Label {
                                        text: "WEAPON USE POLICY"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Label {
                                        text: tabContentLoader.currentTabData.weaponAlert ? "FREE" : "RESTRICTED"
                                        color: tabContentLoader.currentTabData.weaponAlert ? "green" : "red"
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Label {
                                        text: "AIR RAID WARNING"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Label {
                                        text: tabContentLoader.currentTabData.airRaidWarning ? "ON" : "OFF"
                                        color: tabContentLoader.currentTabData.airRaidWarning ? "red" : "green"
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Label {
                                        text: "Radiation Policy"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Label {
                                        text: "RADAR"
                                        color: tabContentLoader.currentTabData.radiationAlert[0].radarAlert ? "green" : "red"
                                    }
                                    Label {
                                        text: "SONAR"
                                        color: tabContentLoader.currentTabData.radiationAlert[1].sonarAlert ? "green" : "red"
                                    }
                                    Label {
                                        text: "COMM."
                                        color: tabContentLoader.currentTabData.radiationAlert[2].communicationAlert ? "green" : "red"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
