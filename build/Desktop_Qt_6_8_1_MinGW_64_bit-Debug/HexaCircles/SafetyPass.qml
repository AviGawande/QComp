import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 300
    height: 200

    // Public properties
    property real dialProgress: 0.0
    property bool isDialComplete: dialProgress >= 1.0
    property int timerDuration: 7000
    property bool autoStart: true

    // Signals
    signal dialStarted()
    signal dialCompleted()

    // Public functions
    function startDial() {
        progressAnimation.restart()
        dialStarted()
    }

    function resetDial() {
        progressAnimation.stop()
        dialProgress = 0.0
    }

    // Auto-start
    Component.onCompleted: {
        if (autoStart) {
            startDial()
        }
    }

    // Animation
    NumberAnimation {
        id: progressAnimation
        target: root
        property: "dialProgress"
        from: 0.0
        to: 1.0
        duration: root.timerDuration
        easing.type: Easing.InOutQuad
        onFinished: dialCompleted()
    }

    // Main container
    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"
        border.color: "#333"
        border.width: 2

        // Title
        Text {
            text: "SAFETY-D"
            font.pixelSize: 16
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        Text {
            text: "PASS"
            font.pixelSize: 14
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 45
        }

        // Dial area
        Item {
            id: dialArea
            width: 160
            height: 100
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 10

            // Background arc
            Canvas {
                id: backgroundCanvas
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    var centerX = width / 2
                    var centerY = height - 20
                    var radius = 50

                    // Background arc from 60° to 390°
                    ctx.strokeStyle = "#ddd"
                    ctx.lineWidth = 6
                    ctx.lineCap = "round"
                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, Math.PI/3, 13*Math.PI/6, false)
                    ctx.stroke()
                }
            }

            // Progress arc
            Canvas {
                id: progressCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    if (root.dialProgress > 0) {
                        var centerX = width / 2
                        var centerY = height - 20
                        var radius = 50
                        var startAngle = Math.PI / 3; // 60 degrees
                        var totalRange = 11 * Math.PI / 6; // 330 degrees
                        var endAngle = startAngle + (totalRange * root.dialProgress);

                        ctx.strokeStyle = root.isDialComplete ? "#4CAF50" : "#2196F3"
                        ctx.lineWidth = 6
                        ctx.lineCap = "round"
                        ctx.beginPath()
                        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                        ctx.stroke()
                    }
                }

                Connections {
                    target: root
                    function onDialProgressChanged() {
                        progressCanvas.requestPaint()
                    }
                }
            }

            // Center tick icon
            Rectangle {
                width: 30
                height: 30
                radius: 15
                color: root.isDialComplete ? "#4CAF50" : "#999"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15

                Behavior on color {
                    ColorAnimation { duration: 300 }
                }

                // Checkmark
                Canvas {
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "white"
                        ctx.lineWidth = 2
                        ctx.lineCap = "round"
                        ctx.beginPath()
                        ctx.moveTo(width * 0.25, height * 0.5)
                        ctx.lineTo(width * 0.45, height * 0.7)
                        ctx.lineTo(width * 0.75, height * 0.3)
                        ctx.stroke()
                    }
                }
            }
        }

        // Control buttons
        Row {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            spacing: 5

            Button {
                text: "Start"
                onClicked: root.startDial()
            }

            Button {
                text: "Reset"
                onClicked: root.resetDial()
            }
        }
    }
}
