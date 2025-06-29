// Layout.qml - Complete layout with dynamic components
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: layoutRoot

    // Main container for the dynamic components
    Rectangle {
        id: mainContainer
        anchors.centerIn: parent
        width: 1370
        height: 223
        color: "#f8f9fa"
        border.color: "#dee2e6"
        border.width: 1
        radius: 8

        // Content container with padding
        Rectangle {
            id: contentContainer
            anchors.fill: parent
            anchors.margins: 7 // This gives us 1357x213 inner dimensions
            color: "transparent"

            RowLayout {
                id: mainRowLayout
                anchors.fill: parent
                spacing: 8

                // Component 1 - Circle/Circular element
                Rectangle {
                    id: component1
                    Layout.fillHeight: true
                    Layout.preferredWidth: 120
                    Layout.minimumWidth: 100
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 1 clicked")
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 60
                        height: 60
                        radius: 30
                        color: "transparent"
                        border.color: "#6c757d"
                        border.width: 2
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 8
                        text: "1"
                        font.bold: true
                        font.pixelSize: 12
                        color: "#495057"
                    }
                }

                // Component 2 - Grid layout
                Rectangle {
                    id: component2
                    Layout.fillHeight: true
                    Layout.preferredWidth: 140
                    Layout.minimumWidth: 120
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 2 clicked")
                    }

                    Grid {
                        anchors.centerIn: parent
                        columns: 2
                        rows: 3
                        spacing: 8

                        Repeater {
                            model: 6
                            Rectangle {
                                width: 28
                                height: 22
                                color: "transparent"
                                border.color: "#6c757d"
                                border.width: 1
                                radius: 2
                            }
                        }
                    }
                }

                // Component 3 - Document with arrows
                Rectangle {
                    id: component3
                    Layout.fillHeight: true
                    Layout.preferredWidth: 130
                    Layout.minimumWidth: 110
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 3 clicked")
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 60
                        height: 80
                        color: "transparent"
                        border.color: "#6c757d"
                        border.width: 1
                        radius: 2

                        Canvas {
                            anchors.centerIn: parent
                            width: 30
                            height: 20
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#6c757d";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                ctx.moveTo(15, 5);
                                ctx.lineTo(15, 15);
                                ctx.moveTo(10, 10);
                                ctx.lineTo(15, 15);
                                ctx.lineTo(20, 10);
                                ctx.stroke();
                            }
                        }
                    }
                }

                // Component 4 - Diagonal arrow document
                Rectangle {
                    id: component4
                    Layout.fillHeight: true
                    Layout.preferredWidth: 130
                    Layout.minimumWidth: 110
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 4 clicked")
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 60
                        height: 80
                        color: "transparent"
                        border.color: "#6c757d"
                        border.width: 1
                        radius: 2

                        Canvas {
                            anchors.centerIn: parent
                            width: 40
                            height: 40
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#6c757d";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                ctx.moveTo(10, 30);
                                ctx.lineTo(30, 10);
                                ctx.moveTo(25, 10);
                                ctx.lineTo(30, 10);
                                ctx.lineTo(30, 15);
                                ctx.stroke();
                            }
                        }
                    }
                }

                // Component 5 - Horizontal arrows document
                Rectangle {
                    id: component5
                    Layout.fillHeight: true
                    Layout.preferredWidth: 130
                    Layout.minimumWidth: 110
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 5 clicked")
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 60
                        height: 80
                        color: "transparent"
                        border.color: "#6c757d"
                        border.width: 1
                        radius: 2

                        Canvas {
                            anchors.centerIn: parent
                            width: 50
                            height: 20
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#6c757d";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                // Main line
                                ctx.moveTo(5, 10);
                                ctx.lineTo(45, 10);
                                // Left arrow
                                ctx.moveTo(10, 5);
                                ctx.lineTo(5, 10);
                                ctx.lineTo(10, 15);
                                // Right arrow
                                ctx.moveTo(40, 5);
                                ctx.lineTo(45, 10);
                                ctx.lineTo(40, 15);
                                ctx.stroke();
                            }
                        }
                    }
                }

                // Component 6 - List with lines
                Rectangle {
                    id: component6
                    Layout.fillHeight: true
                    Layout.preferredWidth: 10
                    Layout.minimumWidth: 100
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 6 clicked")
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Repeater {
                            model: 6
                            Rectangle {
                                width: 80
                                height: 3
                                color: "#6c757d"
                                radius: 1
                            }
                        }
                    }
                }
                // Component 8 - Grid with sub-components
                Rectangle {
                    id: component8
                    Layout.fillHeight: true
                    Layout.preferredWidth: 200
                    Layout.minimumWidth: 180
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 8 clicked")
                    }

                    Grid {
                        anchors.centerIn: parent
                        anchors.topMargin: 20
                        columns: 2
                        rows: 2
                        spacing: 10

                        Repeater {
                            model: 4
                            Rectangle {
                                width: 70
                                height: 60
                                color: "transparent"
                                border.color: "#6c757d"
                                border.width: 1
                                radius: 3

                                Text {
                                    anchors.centerIn: parent
                                    text: "Sub " + (index + 1)
                                    font.pixelSize: 10
                                    color: "#6c757d"
                                }
                            }
                        }
                    }

                    // SONAR section at bottom
                    Row {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 25
                        spacing: 5

                        Text {
                            text: "SONAR"
                            font.pixelSize: 10
                            color: "#6c757d"
                        }

                        Rectangle {
                            width: 25
                            height: 12
                            color: "transparent"
                            border.color: "#6c757d"
                            border.width: 1
                            radius: 2
                            Text {
                                anchors.centerIn: parent
                                text: "ACT"
                                font.pixelSize: 8
                                color: "#6c757d"
                            }
                        }

                        Rectangle {
                            width: 25
                            height: 12
                            color: "transparent"
                            border.color: "#6c757d"
                            border.width: 1
                            radius: 2
                            Text {
                                anchors.centerIn: parent
                                text: "DR"
                                font.pixelSize: 8
                                color: "#6c757d"
                            }
                        }
                    }
                }

                // Component 9 - Target Type section
                Rectangle {
                    id: component9
                    Layout.fillHeight: true
                    Layout.preferredWidth: 150
                    Layout.minimumWidth: 130
                    color: "white"
                    border.color: "#adb5bd"
                    border.width: 1
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#f8f9fa"
                        onExited: parent.color = "white"
                        onClicked: console.log("Component 9 clicked")
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "TARGET"
                            font.pixelSize: 12
                            font.bold: true
                            color: "#495057"
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "TYPE"
                            font.pixelSize: 12
                            font.bold: true
                            color: "#495057"
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 80
                            height: 25
                            color: "transparent"
                            border.color: "#6c757d"
                            border.width: 1
                            radius: 3

                            Text {
                                anchors.centerIn: parent
                                text: "SURF"
                                font.pixelSize: 10
                                font.bold: true
                                color: "#495057"
                            }
                        }
                    }
                }
            }
        }
    }
}
