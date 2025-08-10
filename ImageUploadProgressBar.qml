// ImageUploaderProgressBar.qml
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
    id: root
    width: 600
    height: 500
    color: "#f5f5f5"

    property int currentStep: 0  // 0-based index (0=A, 1=B, 2=C, 3=D)
    property string uploadedImagePath: ""

    // Step labels
    readonly property var stepLabels: ["A", "B", "C", "D"]

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30

        // Progress Bar Section
        Rectangle {
            width: parent.width
            height: 80
            color: "transparent"

            Item {
                anchors.centerIn: parent
                width: 480
                height: 60

                // Background connecting line (full width)
                Rectangle {
                    id: backgroundLine
                    width: 420
                    height: 3
                    anchors.centerIn: parent
                    color: "#E0E0E0"
                }

                // Progress line (shows completion)
                Rectangle {
                    id: progressLine
                    width: root.currentStep === 0 ? 0 : (root.currentStep * 140)
                    height: 3
                    anchors.left: backgroundLine.left
                    anchors.verticalCenter: backgroundLine.verticalCenter
                    color: "#4CAF50"

                    Behavior on width {
                        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                    }
                }

                // Step Indicators
                Repeater {
                    model: 4

                    Rectangle {
                        id: indicator
                        width: 40
                        height: 40
                        radius: 20
                        x: index * 140  // Equal spacing of 140px between centers
                        anchors.verticalCenter: parent.verticalCenter

                        color: {
                            if (index < root.currentStep) return "#4CAF50"  // Completed - green
                            else if (index === root.currentStep) return "#2196F3"  // Current - blue
                            else return "white"  // Pending - white
                        }

                        border.width: 3
                        border.color: {
                            if (index < root.currentStep) return "#4CAF50"
                            else if (index === root.currentStep) return "#2196F3"
                            else return "#E0E0E0"
                        }

                        // Tick icon for completed steps or step label
                        Text {
                            anchors.centerIn: parent
                            text: index < root.currentStep ? "✓" : root.stepLabels[index]
                            color: {
                                if (index < root.currentStep) return "white"
                                else if (index === root.currentStep) return "white"
                                else return "#9E9E9E"
                            }
                            font.pixelSize: index < root.currentStep ? 18 : 16
                            font.bold: true
                        }

                        // Subtle shadow for better visibility
                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: 2
                            radius: parent.radius
                            color: "#00000010"
                            z: -1
                        }
                    }
                }
            }

            // "Upload" label
            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "Upload"
                font.pixelSize: 14
                font.bold: true
                color: "#333333"
            }
        }

        // Upload Area (visible only on first step)
        Rectangle {
            width: parent.width
            height: 300
            visible: root.currentStep === 0
            color: "white"
            border.width: 2
            border.color: "#2196F3"
            radius: 8

            // Dashed border effect
            Rectangle {
                anchors.fill: parent
                anchors.margins: 4
                color: "transparent"
                border.width: 2
                border.color: "#E3F2FD"
                radius: 6

                // Dashed pattern using repeater
                Item {
                    anchors.fill: parent

                    // Top border dashes
                    Row {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 8
                        Repeater {
                            model: 15
                            Rectangle { width: 12; height: 2; color: "#2196F3" }
                        }
                    }

                    // Bottom border dashes
                    Row {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 8
                        Repeater {
                            model: 15
                            Rectangle { width: 12; height: 2; color: "#2196F3" }
                        }
                    }

                    // Left border dashes
                    Column {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8
                        Repeater {
                            model: 8
                            Rectangle { width: 2; height: 12; color: "#2196F3" }
                        }
                    }

                    // Right border dashes
                    Column {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8
                        Repeater {
                            model: 8
                            Rectangle { width: 2; height: 12; color: "#2196F3" }
                        }
                    }
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 20

                    // Upload icon
                    Rectangle {
                        width: 60
                        height: 40
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#2196F3"

                        // Upload arrow
                        Canvas {
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.clearRect(0, 0, width, height);
                                ctx.strokeStyle = "white";
                                ctx.lineWidth = 3;
                                ctx.lineCap = "round";

                                // Draw upload arrow
                                ctx.beginPath();
                                // Horizontal base
                                ctx.moveTo(15, 25);
                                ctx.lineTo(45, 25);
                                // Vertical stem
                                ctx.moveTo(30, 30);
                                ctx.lineTo(30, 10);
                                // Arrow head
                                ctx.moveTo(25, 15);
                                ctx.lineTo(30, 10);
                                ctx.lineTo(35, 15);
                                ctx.stroke();
                            }
                        }
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: root.uploadedImagePath ? "Image Uploaded!" : "Upload Image\nHere"
                        font.pixelSize: 16
                        color: root.uploadedImagePath ? "#4CAF50" : "#2196F3"
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                    }

                    // Upload button
                    Button {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Choose File"
                        onClicked: fileDialog.open()

                        background: Rectangle {
                            color: parent.hovered ? "#1976D2" : "#2196F3"
                            radius: 4
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: fileDialog.open()
                }
            }
        }

        // Content area for other steps
        Rectangle {
            width: parent.width
            height: 300
            visible: root.currentStep > 0
            color: "white"
            border.width: 1
            border.color: "#E0E0E0"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "Step " + root.stepLabels[root.currentStep] + " Content"
                font.pixelSize: 24
                color: "#333333"
            }
        }

        // Navigation buttons
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Button {
                text: "Previous"
                enabled: root.currentStep > 0
                onClicked: {
                    if (root.currentStep > 0) {
                        root.currentStep--
                    }
                }

                background: Rectangle {
                    color: parent.enabled ? (parent.hovered ? "#757575" : "#9E9E9E") : "#E0E0E0"
                    radius: 4
                }

                contentItem: Text {
                    text: parent.text
                    color: parent.enabled ? "white" : "#BDBDBD"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                text: root.currentStep < 3 ? "Next" : "Finish"
                enabled: root.currentStep === 0 ? root.uploadedImagePath !== "" : true
                onClicked: {
                    if (root.currentStep < 3) {
                        root.currentStep++
                    } else {
                        console.log("Process completed!")
                        // Reset to beginning for demo
                        root.currentStep = 0
                        root.uploadedImagePath = ""
                    }
                }

                background: Rectangle {
                    color: parent.enabled ? (parent.hovered ? "#1976D2" : "#2196F3") : "#E0E0E0"
                    radius: 4
                }

                contentItem: Text {
                    text: parent.text
                    color: parent.enabled ? "white" : "#BDBDBD"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // File Dialog
    FileDialog {
        id: fileDialog
        title: "Select Image"
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.gif *.bmp)"]
        onAccepted: {
            root.uploadedImagePath = fileUrl.toString()
            console.log("Selected file:", root.uploadedImagePath)
        }
    }
}
