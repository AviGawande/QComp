import QtQuick 2.15
import QtQuick.Shapes 1.15

Rectangle {
    id: root
    width: 308
    height: 55
    border.color: "#2E4F99"
    border.width: 2
    color: "#F0F8FF"

    // Properties for external control
    property real ownShipX: 25
    property real targetX: 283
    property real weaponProgress: 0.0  // 0.0 to 1.0
    property string status: "Ready"
    property real ownShipToTargetDistance: 4.6  // Total distance in Nm
    property real weaponToTargetDistance: 4.6   // Remaining distance

    // Calculate weapon position based on progress
    property real weaponX: ownShipX + (targetX - ownShipX) * weaponProgress

    // Update weapon to target distance based on progress
    onWeaponProgressChanged: {
        weaponToTargetDistance = ownShipToTargetDistance * (1.0 - weaponProgress)
        if (weaponProgress >= 1.0) {
            status = "Target Hit"
        } else if (weaponProgress > 0) {
            status = "Weapon In Flight"
        }
    }

    // Own Ship (OS) - Circle with cross
    Item {
        id: ownShip
        x: root.ownShipX - 12
        y: root.height / 2 - 12
        width: 24
        height: 24

        Rectangle {
            anchors.centerIn: parent
            width: 20
            height: 20
            radius: 10
            color: "transparent"
            border.color: "#2E4F99"
            border.width: 2
        }

        // Cross inside circle
        Rectangle {
            anchors.centerIn: parent
            width: 12
            height: 2
            color: "#2E4F99"
        }
        Rectangle {
            anchors.centerIn: parent
            width: 2
            height: 12
            color: "#2E4F99"
        }
    }

    // Own Ship Label
    Text {
        x: root.ownShipX - 8
        y: root.height / 2 + 15
        text: "OS"
        font.pixelSize: 10
        font.bold: true
        color: "#2E4F99"
    }

    // Target (TGT) - Diamond shape
    Item {
        id: target
        x: root.targetX - 10
        y: root.height / 2 - 10
        width: 20
        height: 20

        // Animate target movement
        Behavior on x {
            NumberAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        Shape {
            anchors.fill: parent
            ShapePath {
                strokeColor: "#2E4F99"
                strokeWidth: 2
                fillColor: "transparent"

                startX: 10; startY: 0
                PathLine { x: 20; y: 10 }
                PathLine { x: 10; y: 20 }
                PathLine { x: 0; y: 10 }
                PathLine { x: 10; y: 0 }
            }
        }
    }

    // Target Label and Distance
    Text {
        x: root.targetX - 8
        y: root.height / 2 + 15
        text: "TGT"
        font.pixelSize: 10
        font.bold: true
        color: "#2E4F99"
    }

    // Weapon (WPN) - Torpedo shape
    Item {
        id: weapon
        x: root.weaponX - 15
        y: root.height / 2 - 6
        width: 30
        height: 12
        visible: root.weaponProgress > 0

        // Torpedo body
        Rectangle {
            width: 25
            height: 8
            y: 2
            color: "#2E4F99"
            radius: 4
        }

        // Torpedo nose (triangle)
        Shape {
            x: 25
            y: 0
            width: 8
            height: 12
            ShapePath {
                strokeColor: "#2E4F99"
                fillColor: "#2E4F99"

                startX: 0; startY: 2
                PathLine { x: 5; y: 6 }
                PathLine { x: 0; y: 10 }
                PathLine { x: 0; y: 2 }
            }
        }

        // Weapon trail animation
        Rectangle {
            x: -10
            y: 5
            width: 8
            height: 2
            color: "#87CEEB"
            opacity: 0.7

            SequentialAnimation on opacity {
                running: root.weaponProgress > 0 && root.weaponProgress < 1.0
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 300 }
                NumberAnimation { to: 0.7; duration: 300 }
            }
        }
    }

    // Weapon Label
    Text {
        x: root.weaponX - 10
        y: root.height / 2 - 20
        text: "WPN"
        font.pixelSize: 8
        font.bold: true
        color: "#2E4F99"
        visible: root.weaponProgress > 0 && root.weaponProgress < 1.0
    }

    // Dashed line from OS to Weapon
    Shape {
        anchors.fill: parent
        visible: root.weaponProgress > 0

        ShapePath {
            strokeColor: "#2E4F99"
            strokeWidth: 1
            strokeStyle: ShapePath.DashLine
            dashPattern: [4, 2]

            startX: root.ownShipX + 12
            startY: root.height / 2
            PathLine {
                x: root.weaponX
                y: root.height / 2
            }
        }
    }

    // Solid line from Weapon to Target
    Shape {
        anchors.fill: parent
        visible: root.weaponProgress > 0 && root.weaponProgress < 1.0

        ShapePath {
            strokeColor: "#2E4F99"
            strokeWidth: 1

            startX: root.weaponX
            startY: root.height / 2
            PathLine {
                x: root.targetX - 10
                y: root.height / 2
            }
        }
    }

    // Distance from OS to Weapon
    Text {
        x: (root.ownShipX + root.weaponX) / 2 - 15
        y: root.height / 2 - 15
        text: (root.ownShipToTargetDistance * root.weaponProgress).toFixed(1) + " Nm"
        font.pixelSize: 8
        color: "#2E4F99"
        visible: root.weaponProgress > 0 && root.weaponProgress < 1.0
    }

    // Distance from Weapon to Target
    Text {
        x: (root.weaponX + root.targetX) / 2 - 15
        y: root.height / 2 + 8
        text: root.weaponToTargetDistance.toFixed(1) + " Nm"
        font.pixelSize: 8
        color: "#2E4F99"
        visible: root.weaponProgress > 0 && root.weaponProgress < 1.0
    }

    // Animation for weapon movement
    NumberAnimation {
        id: weaponAnimation
        target: root
        property: "weaponProgress"
        from: 0.0
        to: 1.0
        duration: 5000  // 5 seconds for full travel
        easing.type: Easing.Linear
    }

    // Timer for real-time updates simulation
    Timer {
        id: simulationTimer
        interval: 100
        running: false
        repeat: true
        property real targetMovement: 0

        onTriggered: {
            // Simulate target movement
            targetMovement += 0.5
            if (targetMovement > 30) targetMovement = -30
            // You can update target position here based on external data
        }
    }

    // Public functions for external control
    function fireTorpedo() {
        if (status === "Ready" || status === "Target Hit") {
            reset()
            status = "Firing"
            weaponAnimation.start()
            simulationTimer.start()
        }
    }

    function moveTarget() {
        // Simulate random target movement
        var newX = Math.random() * (width - 60) + 50
        targetX = Math.max(50, Math.min(width - 20, newX))
    }

    function reset() {
        weaponAnimation.stop()
        simulationTimer.stop()
        weaponProgress = 0.0
        status = "Ready"
        weaponToTargetDistance = ownShipToTargetDistance
    }

    // Functions to update from external data
    function updateWeaponProgress(progress) {
        weaponProgress = Math.max(0.0, Math.min(1.0, progress))
    }

    function updateTargetPosition(newX) {
        targetX = Math.max(50, Math.min(width - 20, newX))
    }

    function updateDistances(totalDistance) {
        ownShipToTargetDistance = totalDistance
        weaponToTargetDistance = totalDistance * (1.0 - weaponProgress)
    }

    // Function to update all parameters at once (for real-time data)
    function updateTorpedoData(weaponProg, targetPosX, totalDist) {
        ownShipToTargetDistance = totalDist
        targetX = Math.max(50, Math.min(width - 20, targetPosX))
        weaponProgress = Math.max(0.0, Math.min(1.0, weaponProg))
    }
}
