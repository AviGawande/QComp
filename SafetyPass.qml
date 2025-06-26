import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    // Public properties for external control
    property real dialProgress: 0.0  // 0.0 to 1.0
    property bool isDialComplete: dialProgress >= 1.0
    property int timerDuration: 7000  // 7 seconds
    property bool autoStart: true

    // Signals for external communication
    signal dialStarted()
    signal dialCompleted()
    signal dialProgress(real progress)

    // Public functions
    function startDial() {
        progressAnimation.restart()
        dialStarted()
    }

    function resetDial() {
        progressAnimation.stop()
        dialProgress = 0.0
    }

    function pauseDial() {
        progressAnimation.pause()
    }

    function resumeDial() {
        progressAnimation.resume()
    }


    // Auto-start animation if enabled
    Component.onCompleted: {
        if (autoStart) {
            startDial()
        }
    }

    // Progress animation
    NumberAnimation {
        id: progressAnimation
        target: root
        property: "dialProgress"
        from: 0.0
        to: 1.0
        duration: root.timerDuration
        easing.type: Easing.InOutQuad

        onFinished: {
            dialCompleted()
        }

        onRunningChanged: {
            if (running) {
                dialStarted()
            }
        }
    }

    // Monitor progress changes
    onDialProgressChanged: {
        root.dialProgress(dialProgress)
    }

    // Main dial container
    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"
        radius: 8

        // Main container
        Item {
            anchors.centerIn: parent
            width: 180
            height: 120

        // Title
        Text {
            id: titleText
            text: "SAFETY-D"
            font.pixelSize: 16
            font.bold: true
            color: "#333"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }

        Text {
            id: subtitleText
            text: "PASS"
            font.pixelSize: 14
            font.bold: true
            color: "#333"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: titleText.bottom
            anchors.topMargin: 5
        }

        // Dial container
        Item {
            id: dialContainer
            width: 140
            height: 80
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: subtitleText.bottom
            anchors.topMargin: 15

            // Background arc (grey)
            Canvas {
                id: backgroundArc
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    var centerX = width / 2
                    var centerY = height - 10
                    var radius = 50
                    var startAngle = Math.PI  // 180 degrees
                    var endAngle = 2 * Math.PI  // 360 degrees (0 degrees)

                    ctx.strokeStyle = "#ddd"
                    ctx.lineWidth = 8
                    ctx.lineCap = "round"
                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                    ctx.stroke()
                }
            }

            // Start marker (perpendicular to arc at start point)
            Rectangle {
                id: startMarker
                width: 3
                height: 15
                color: "#666"
                radius: 1.5

                // Position at start of arc (left side, perpendicular to arc)
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 15
                anchors.verticalCenterOffset: 25

                // Rotate to be perpendicular to the arc at start point (tangent)
                rotation: -90
            }

            // End marker (perpendicular to arc at end point)
            Rectangle {
                id: endMarker
                width: 3
                height: 15
                color: root.isDialComplete ? "#4CAF50" : "#666"
                radius: 1.5

                // Position at end of arc (right side, perpendicular to arc)
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 15
                anchors.verticalCenterOffset: 25

                // Rotate to be perpendicular to the arc at end point (tangent)
                rotation: 90

                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }

            // Progress arc (blue)
            Canvas {
                id: progressArc
                anchors.fill: parent

                property real currentProgress: root.dialProgress

                onCurrentProgressChanged: {
                    requestPaint()
                }

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    if (currentProgress > 0) {
                        var centerX = width / 2
                        var centerY = height - 10
                        var radius = 50
                        var startAngle = Math.PI  // 180 degrees
                        var progressAngle = startAngle + (Math.PI * currentProgress)  // Progress from left to right

                        ctx.strokeStyle = root.isDialComplete ? "#4CAF50" : "#2196F3"
                        ctx.lineWidth = 8
                        ctx.lineCap = "round"
                        ctx.beginPath()
                        ctx.arc(centerX, centerY, radius, startAngle, progressAngle, false)
                        ctx.stroke()
                    }
                }
            }

            // Tick icon in center
            Rectangle {
                id: tickContainer
                width: 32
                height: 32
                radius: 16
                color: root.isDialComplete ? "#4CAF50" : "#999"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }

                // Tick mark
                Canvas {
                    id: tickIcon
                    anchors.fill: parent

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)

                        // Draw tick mark
                        ctx.strokeStyle = "white"
                        ctx.lineWidth = 3
                        ctx.lineCap = "round"
                        ctx.lineJoin = "round"

                        ctx.beginPath()
                        ctx.moveTo(width * 0.25, height * 0.5)
                        ctx.lineTo(width * 0.45, height * 0.7)
                        ctx.lineTo(width * 0.75, height * 0.3)
                        ctx.stroke()
                    }
                }
            }
        }

        // Progress text (optional)
        Text {
            text: Math.round(root.dialProgress * 100) + "%"
            font.pixelSize: 12
            color: "#666"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }
        }

        // Control buttons for testing
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

            Button {
                text: "Pause"
                onClicked: root.pauseDial()
            }
        }
    }
}
