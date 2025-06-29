import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: batteryContainer
    width: 80
    height: 300
    color: "transparent"

    // Properties
    property real batteryPercentage: 84 // Default value, will be updated from system
    property bool isCharging: true
    property int segmentCount: 12 // Number of battery segments

    // Timer to simulate real-time battery updates
    Timer {
        id: batteryUpdateTimer
        interval: 2000 // Update every 2 seconds (for demo)
        running: true
        repeat: true
        onTriggered: {
            // Simulate battery percentage changes (replace with actual system call)
            if (isCharging) {
                batteryPercentage = Math.min(100, batteryPercentage + Math.random() * 3)
                if (batteryPercentage >= 99) isCharging = false
            } else {
                batteryPercentage = Math.max(0, batteryPercentage - Math.random() * 2)
                if (batteryPercentage <= 15) isCharging = true
            }
        }
    }

    Column {
        anchors.fill: parent
        spacing: 8

        // Header with lightning icon and percentage
        Rectangle {
            width: parent.width
            height: 40
            color: "#2c3e50"
            radius: 6
            border.color: "#34495e"
            border.width: 1

            Row {
                anchors.centerIn: parent
                spacing: 6

                // Lightning bolt icon
                Canvas {
                    width: 16
                    height: 20
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = isCharging ? "#f1c40f" : "#95a5a6";
                        ctx.beginPath();
                        // Lightning bolt shape
                        ctx.moveTo(8, 2);
                        ctx.lineTo(12, 2);
                        ctx.lineTo(6, 10);
                        ctx.lineTo(10, 10);
                        ctx.lineTo(4, 18);
                        ctx.lineTo(8, 10);
                        ctx.lineTo(4, 10);
                        ctx.lineTo(8, 2);
                        ctx.closePath();
                        ctx.fill();
                    }

                    // Repaint when charging status changes
                    Connections {
                        target: batteryContainer
                        function onIsChargingChanged() {
                            requestPaint()
                        }
                    }
                }

                // Percentage text
                Text {
                    text: Math.round(batteryPercentage) + "%"
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Battery visual container
        Rectangle {
            width: parent.width
            height: parent.height - 48 // Remaining height after header
            color: "#ecf0f1"
            radius: 8
            border.color: "#bdc3c7"
            border.width: 2

            // Battery segments container
            Column {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 2

                Repeater {
                    model: segmentCount

                    Rectangle {
                        width: parent.width
                        height: (parent.height - (segmentCount - 1) * 2) / segmentCount
                        radius: 2

                        // Calculate if this segment should be filled
                        property int segmentIndex: segmentCount - index - 1 // Reverse order (top to bottom)
                        property real segmentThreshold: (segmentIndex + 1) * (100 / segmentCount)
                        property bool isFilled: batteryPercentage >= segmentThreshold

                        // Color based on battery level and fill state
                        color: {
                            if (!isFilled) return "#d5dbdb"

                            // Color coding based on battery level
                            if (batteryPercentage > 60) return "#27ae60" // Green
                            else if (batteryPercentage > 30) return "#f39c12" // Orange
                            else return "#e74c3c" // Red
                        }

                        border.color: {
                            if (!isFilled) return "#bdc3c7"

                            if (batteryPercentage > 60) return "#229954"
                            else if (batteryPercentage > 30) return "#d68910"
                            else return "#cb4335"
                        }
                        border.width: 1

                        // Subtle animation when segment state changes
                        Behavior on color {
                            ColorAnimation { duration: 300 }
                        }

                        // Charging animation effect
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 1
                            radius: parent.radius - 1
                            color: "white"
                            opacity: 0
                            visible: isCharging && parent.isFilled

                            SequentialAnimation on opacity {
                                running: isCharging && parent.isFilled
                                loops: Animation.Infinite
                                PauseAnimation { duration: index * 100 } // Stagger the animation
                                NumberAnimation { to: 0.4; duration: 500 }
                                NumberAnimation { to: 0; duration: 500 }
                            }
                        }
                    }
                }
            }

            // Battery terminal (small rectangle at top)
            Rectangle {
                width: parent.width * 0.4
                height: 6
                color: "#7f8c8d"
                radius: 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: -4
            }
        }
    }

    // Status text at bottom (optional)
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: -25
        text: {
            if (isCharging) return "Charging"
            else if (batteryPercentage < 15) return "Low Battery"
            else return "On Battery"
        }
        font.pixelSize: 10
        color: {
            if (isCharging) return "#27ae60"
            else if (batteryPercentage < 15) return "#e74c3c"
            else return "#7f8c8d"
        }
        font.bold: batteryPercentage < 15
    }

    // Functions to integrate with system battery API
    function updateBatteryLevel(percentage) {
        batteryPercentage = Math.max(0, Math.min(100, percentage))
    }

    function setChargingStatus(charging) {
        isCharging = charging
    }

    // For real system integration, you would call these from C++:
    // Component.onCompleted: {
    //     batteryManager.batteryLevelChanged.connect(updateBatteryLevel)
    //     batteryManager.chargingStatusChanged.connect(setChargingStatus)
    // }
}
