// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// Rectangle {
//     id: messageContainer
//     width: 450
//     height: 350
//     color: "transparent"
//     visible: true

//     Rectangle {
//         anchors.fill: parent
//         color: "#99000000"
//     }

//     Rectangle {
//         id: messagePanel
//         width: 450
//         height: 350
//         anchors.centerIn: parent
//         color: "transparent"
//         radius: 8

//         // Header
//         Rectangle {
//             id: header
//             width: parent.width
//             height: 50
//             color: "transparent"

//             Text {
//                 text: "Machine"
//                 font.pixelSize: 20
//                 font.bold: true
//                 color: "white"
//                 anchors.left: parent.left
//                 anchors.leftMargin: 20
//                 anchors.verticalCenter: parent.verticalCenter
//             }

//             Text {
//                 text: "✕"
//                 font.pixelSize: 16
//                 color: "white"
//                 anchors.right: parent.right
//                 anchors.rightMargin: 20
//                 anchors.verticalCenter: parent.verticalCenter

//                 MouseArea {
//                     anchors.fill: parent
//                     onClicked: messageContainer.visible = false
//                 }
//             }
//         }

//         // Custom tab bar
//         Item {
//             id: customTabBar
//             width: parent.width
//             height: 40
//             anchors.top: header.bottom
//             property int currentIndex: 0

//             Rectangle {
//                 width: parent.width
//                 height: 1
//                 color: "#444"
//                 anchors.bottom: parent.bottom
//             }

//             Row {
//                 spacing: 0
//                 anchors.fill: parent

//                 Repeater {
//                     model: ["ORDER", "ENGAGEMENT", "SHORT"]
//                     delegate: Item {
//                         width: customTabBar.width / 3
//                         height: parent.height

//                         Text {
//                             text: modelData
//                             color: customTabBar.currentIndex === index ? "#7FFF00" : "white"
//                             font.pixelSize: 14
//                             anchors.centerIn: parent
//                         }

//                         Rectangle {
//                             visible: customTabBar.currentIndex === index
//                             height: 2
//                             width: parent.width / 2
//                             color: "#7FFF00"
//                             anchors.bottom: parent.bottom
//                             anchors.horizontalCenter: parent.horizontalCenter
//                         }

//                         MouseArea {
//                             anchors.fill: parent
//                             onClicked: customTabBar.currentIndex = index
//                         }
//                     }
//                 }
//             }
//         }

//         // Tab content area
//         Item {
//             id: tabContent
//             anchors.top: customTabBar.bottom
//             anchors.topMargin: 10
//             anchors.left: parent.left
//             anchors.right: parent.right
//             anchors.bottom: parent.bottom
//             anchors.margins: 10

//             // Mock dynamic message list per machine
//             property var messageMap: ({
//                 "Machine 1": ["System Check", "Maintenance Alert"],
//                 "Machine 2": ["Temperature Warning"],
//                 "Machine 3": ["Low Pressure", "Filter Change", "Calibration Needed"]
//             })

//             Column {
//                 anchors.fill: parent
//                 spacing: 10

//                 // Machine selector
//                 ComboBox {
//                     id: machineSelector
//                     width: parent.width
//                     model: Object.keys(tabContent.messageMap)
//                     currentIndex: -1
//                     displayText: currentIndex >= 0 ? currentText : "Select Machine"

//                     background: Rectangle {
//                         color: "#333"
//                         border.color: "#555"
//                         radius: 4
//                     }

//                     contentItem: Text {
//                         text: machineSelector.displayText
//                         color: "white"
//                         verticalAlignment: Text.AlignVCenter
//                         leftPadding: 10
//                     }
//                 }

//                 // Message list
//                 ListView {
//                     width: parent.width
//                     height: parent.height - machineSelector.height - 20
//                     spacing: 4
//                     visible: machineSelector.currentIndex >= 0
//                     model: machineSelector.currentIndex >= 0 ? tabContent.messageMap[machineSelector.currentText] : []

//                     delegate: Column {
//                         width: parent ? parent.width : 0
//                         property bool expanded: false

//                         Rectangle {
//                             id: msgRect
//                             width: parent.width
//                             height: 40
//                             radius: 4
//                             color: "#333"
//                             border.color: "#555"

//                             MouseArea {
//                                 anchors.fill: parent
//                                 onClicked: parent.parent.expanded = !parent.parent.expanded
//                             }

//                             RowLayout {
//                                 anchors.fill: parent
//                                 anchors.margins: 10
//                                 spacing: 20

//                                 Text {
//                                     text: modelData
//                                     color: "white"
//                                     Layout.fillWidth: true
//                                 }

//                                 Text {
//                                     text: parent.parent.parent.expanded ? "▲" : "▼"
//                                     color: "white"
//                                 }
//                             }
//                         }

//                         // Expanded content
//                         Column {
//                             width: parent.width
//                             spacing: 4
//                             visible: parent.expanded

//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Air Pressure"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "Normal"
//                                         color: "green"
//                                     }
//                                 }
//                             }

//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Water Flow"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "Critical"
//                                         color: "red"
//                                     }
//                                 }
//                             }

//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Temperature"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "OK"
//                                         color: "orange"
//                                     }
//                                 }
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }

///   *************** --------- - -- -- - - *********************


// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// Rectangle {
//     id: messageContainer
//     width: 450
//     height: 350
//     color: "transparent"
//     visible: true

//     Rectangle {
//         anchors.fill: parent
//         color: "#99000000"
//     }

//     Rectangle {
//         id: messagePanel
//         width: 450
//         height: 350
//         anchors.centerIn: parent
//         color: "transparent"
//         radius: 8

//         // Header
//         Rectangle {
//             width: parent.width
//             height: 50
//             color: "transparent"

//             Text {
//                 text: "Machine"
//                 font.pixelSize: 20
//                 font.bold: true
//                 color: "white"
//                 anchors.left: parent.left
//                 anchors.leftMargin: 20
//                 anchors.verticalCenter: parent.verticalCenter
//             }

//             Text {
//                 text: "✕"
//                 font.pixelSize: 16
//                 color: "white"
//                 anchors.right: parent.right
//                 anchors.rightMargin: 20
//                 anchors.verticalCenter: parent.verticalCenter

//                 MouseArea {
//                     anchors.fill: parent
//                     onClicked: messageContainer.visible = false
//                 }
//             }
//         }

//         // Custom tab bar
//         Item {
//             id: customTabBar
//             width: parent.width
//             height: 40
//             anchors.top: parent.top
//             anchors.topMargin: 50
//             property int currentIndex: 0

//             Rectangle {
//                 width: parent.width
//                 height: 1
//                 color: "#444"
//                 anchors.bottom: parent.bottom
//             }

//             Row {
//                 spacing: 0
//                 anchors.fill: parent

//                 Repeater {
//                     model: ["ORDER", "ENGAGEMENT", "SHORT"]
//                     delegate: Item {
//                         width: customTabBar.width / 3
//                         height: parent.height

//                         Text {
//                             text: modelData
//                             color: customTabBar.currentIndex === index ? "#7FFF00" : "white"
//                             font.pixelSize: 14
//                             anchors.centerIn: parent
//                         }

//                         Rectangle {
//                             visible: customTabBar.currentIndex === index
//                             height: 2
//                             width: parent.width / 2
//                             color: "#7FFF00"
//                             anchors.bottom: parent.bottom
//                             anchors.horizontalCenter: parent.horizontalCenter
//                         }

//                         MouseArea {
//                             anchors.fill: parent
//                             onClicked: customTabBar.currentIndex = index
//                         }
//                     }
//                 }
//             }
//         }

//         // Components for 3 tabs (must be declared before use)


//         // Tab content loader
//         Loader {
//             id: tabContentLoader
//             property var tabComponents: [orderTab, engageTab, shortTab]

//             anchors.top: customTabBar.bottom
//             anchors.topMargin: 10
//             anchors.left: parent.left
//             anchors.right: parent.right
//             anchors.bottom: parent.bottom
//             sourceComponent: tabComponents[customTabBar.currentIndex]
//         }

//         // ----------- Common Tab Layout Component -----------
//         Component {
//             id: orderTab

//             Column {
//                 anchors.fill: parent
//                 anchors.margins: 10
//                 spacing: 10

//                 // Machine numbers with their incoming messages
//                 property var messageMap: ({
//                     "1": ["Incoming Message 1", "Incoming Message 2"],
//                     "2": ["Incoming Message 1", "Incoming Message 2"]
//                 })

//                 ComboBox {
//                     id: machineSelector
//                     width: parent.width
//                     model: Object.keys(messageMap)
//                     currentIndex: -1
//                     displayText: currentIndex >= 0 ? currentText : "Select Num"

//                     background: Rectangle {
//                         color: "#333"
//                         border.color: "#555"
//                         radius: 4
//                     }

//                     contentItem: Text {
//                         text: machineSelector.displayText
//                         color: "white"
//                         verticalAlignment: Text.AlignVCenter
//                         leftPadding: 10
//                     }
//                 }

//                 ListView {
//                     width: parent.width
//                     height: 200
//                     spacing: 4
//                     visible: machineSelector.currentIndex >= 0
//                     model: machineSelector.currentIndex >= 0 ? messageMap[machineSelector.currentText] : []
//                     delegate: Column {
//                         width: parent.width
//                         property bool expanded: false

//                         Rectangle {
//                             id: msgRect
//                             width: parent.width
//                             height: 40
//                             radius: 4
//                             color: "#333"
//                             border.color: "#555"

//                             MouseArea {
//                                 anchors.fill: parent
//                                 onClicked: parent.parent.expanded = !parent.parent.expanded
//                             }

//                             RowLayout {
//                                 anchors.fill: parent
//                                 anchors.margins: 10
//                                 spacing: 20

//                                 Text {
//                                     text: modelData
//                                     color: "white"
//                                     Layout.fillWidth: true
//                                 }

//                                 Text {
//                                     text: parent.parent.parent.expanded ? "▲" : "▼"
//                                     color: "white"
//                                 }
//                             }
//                         }

//                         // Expandable indicators - exactly 3 parameters
//                         Column {
//                             width: parent.width
//                             spacing: 4
//                             visible: parent.expanded

//                             // 1. Air check
//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Air check"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "Normal"
//                                         color: "green"
//                                     }
//                                 }
//                             }

//                             // 2. Water density
//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Water density"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "High"
//                                         color: "orange"
//                                     }
//                                 }
//                             }

//                             // 3. Lidar
//                             Rectangle {
//                                 width: parent.width
//                                 height: 30
//                                 color: "#222"
//                                 border.color: "#444"
//                                 radius: 2

//                                 RowLayout {
//                                     anchors.fill: parent
//                                     anchors.margins: 10
//                                     spacing: 10

//                                     Text {
//                                         text: "Lidar"
//                                         color: "white"
//                                         Layout.fillWidth: true
//                                     }
//                                     Text {
//                                         text: "Active"
//                                         color: "green"
//                                     }
//                                 }
//                             }
//                         }
//                     }
//                 }
//             }
//         }

//         Component { id: engageTab;  Loader { sourceComponent: orderTab } }
//         Component { id: shortTab;   Loader { sourceComponent: orderTab } }
//     }
// }

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

    Rectangle {
        id: messagePanel
        width: 450
        height: 350
        anchors.centerIn: parent
        color: "transparent"
        radius: 8

        // Header
        Rectangle {
            width: parent.width
            height: 50
            color: "transparent"

            Text {
                text: "Machine"
                font.pixelSize: 20
                font.bold: true
                color: "white"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
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

            Rectangle {
                width: parent.width
                height: 1
                color: "#444"
                anchors.bottom: parent.bottom
            }

            Row {
                spacing: 0
                anchors.fill: parent

                Repeater {
                    model: ["ORDER", "ENGAGEMENT", "SHORT"]
                    delegate: Item {
                        width: customTabBar.width / 3
                        height: parent.height

                        Text {
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

            // Components for 3 tabs (must be declared before use)
            property var tabComponents: [orderTab, engageTab, shortTab]

            anchors.top: customTabBar.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            sourceComponent: tabComponents[customTabBar.currentIndex]
        }

        // ----------- Common Tab Layout Component -----------
        Component {
            id: orderTab

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                // Machine numbers with their incoming messages
                property var messageMap: ({
                    "1": ["Incoming Message 1", "Incoming Message 2"],
                    "2": ["Incoming Message 1", "Incoming Message 2"]
                })

                ComboBox {
                    id: machineSelector
                    width: parent.width
                    model: Object.keys(messageMap)
                    currentIndex: -1
                    displayText: currentIndex >= 0 ? currentText : "Select Num"

                    background: Rectangle {
                        color: "#333"
                        border.color: "#555"
                        radius: 4
                    }

                    contentItem: Text {
                        text: machineSelector.displayText
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }
                }

                // Back button - only visible when a machine is selected
                Rectangle {
                    width: parent.width
                    height: 35
                    color: "#444"
                    border.color: "#666"
                    radius: 4
                    visible: machineSelector.currentIndex >= 0

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            machineSelector.currentIndex = -1
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Text {
                            text: "← Back to Machine Selection"
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
                            id: msgRect
                            width: parent.width
                            height: 40
                            radius: 4
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

                                Text {
                                    text: modelData
                                    color: "white"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: parent.parent.parent.expanded ? "▲" : "▼"
                                    color: "white"
                                }
                            }
                        }

                        // Expandable indicators - exactly 3 parameters
                        Column {
                            width: parent.width
                            spacing: 4
                            visible: parent.expanded

                            // 1. Air check
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"
                                radius: 2

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Text {
                                        text: "Air check"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Text {
                                        text: "Normal"
                                        color: "green"
                                    }
                                }
                            }

                            // 2. Water density
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"
                                radius: 2

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Text {
                                        text: "Water density"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Text {
                                        text: "High"
                                        color: "orange"
                                    }
                                }
                            }

                            // 3. Lidar
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "#222"
                                border.color: "#444"
                                radius: 2

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Text {
                                        text: "Lidar"
                                        color: "white"
                                        Layout.fillWidth: true
                                    }
                                    Text {
                                        text: "Active"
                                        color: "green"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Component { id: engageTab;  Loader { sourceComponent: orderTab } }
        Component { id: shortTab;   Loader { sourceComponent: orderTab } }
    }
}
