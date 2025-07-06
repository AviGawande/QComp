import QtQuick 2.15
import QtQuick.Shapes 1.15

Rectangle {
    id: root
    width: 308
    height: 98
    border.color: "#2E4F99"
    border.width: 2
    color: "#F0F8FF"

    // Properties for wire lengths
    property real maxWireLength: 7.2  // Maximum wire length in meters
    property real osWireLength: 0.0   // Current OS wire length released
    property real weaponWireLength: 0.0  // Current weapon wire length released

    // Calculate progress percentages (0.0 to 1.0)
    property real osWireProgress: osWireLength / maxWireLength
    property real weaponWireProgress: weaponWireLength / maxWireLength

    // Wire rod dimensions
    property real wireRodWidth: 284
    property real wireRodHeight: 11
    property real wireRodStartX: 12

    // OS Wire Section
    Item {
        id: osWireSection
        x: 0
        y: 10
        width: parent.width
        height: 40

        // OS Wire Label
        Text {
            x: 8
            y: 5
            text: "OS WIRE"
            font.pixelSize: 12
            font.bold: true
            color: "#2E4F99"
        }

        // OS Wire Length Display
        Text {
            x: parent.width - 50
            y: 5
            text: root.osWireLength.toFixed(2)
            font.pixelSize: 12
            font.bold: true
            color: "#2E4F99"
        }

        // OS Wire Rod Background
        Rectangle {
            id: osWireBackground
            x: root.wireRodStartX
            y: 20
            width: root.wireRodWidth
            height: root.wireRodHeight
            color: "#E8E8E8"
            border.color: "#2E4F99"
            border.width: 1
        }

        // OS Wire Progress - Diagonal Segments
        Item {
            id: osWireProgressContainer
            x: root.wireRodStartX
            y: 20
            width: root.wireRodWidth
            height: root.wireRodHeight
            clip: true

            // Diagonal segments repeater for OS wire (Green)
            Repeater {
                id: osWireRepeater
                model: Math.floor(root.wireRodWidth / 12)  // Number of diagonal segments

                Item {
                    x: index * 12
                    y: 0
                    width: 12
                    height: root.wireRodHeight
                    visible: index < (root.osWireProgress * osWireRepeater.model)

                    // Diagonal segment using Shape
                    Shape {
                        anchors.fill: parent
                        visible: parent.visible

                        ShapePath {
                            strokeWidth: 0
                            fillColor: "#4CAF50"  // Green color

                            startX: 1
                            startY: 1

                            PathLine { x: 9; y: 1 }                    // Top edge
                            PathLine { x: 11; y: root.wireRodHeight - 1 }  // Right diagonal
                            PathLine { x: 3; y: root.wireRodHeight - 1 }   // Bottom edge
                            PathLine { x: 1; y: 1 }                   // Left diagonal back to start
                        }

                        // Glow effect
                        ShapePath {
                            strokeWidth: 1
                            strokeColor: "#81C784"  // Lighter green
                            fillColor: "transparent"

                            startX: 1
                            startY: 1

                            PathLine { x: 9; y: 1 }
                            PathLine { x: 11; y: root.wireRodHeight - 1 }
                            PathLine { x: 3; y: root.wireRodHeight - 1 }
                            PathLine { x: 1; y: 1 }
                        }
                    }

                    // Animation for each segment appearing
                    Behavior on visible {
                        SequentialAnimation {
                            PauseAnimation { duration: index * 30 }  // Staggered animation
                            PropertyAnimation {
                                target: parent
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: 150
                            }
                        }
                    }
                }
            }
        }

        // OS Wire tick marks
        Repeater {
            model: 8  // For 7.2m divided into segments
            Rectangle {
                x: root.wireRodStartX + (index * root.wireRodWidth / 7)
                y: 32
                width: 1
                height: 6
                color: "#2E4F99"
            }
        }
    }

    // Weapon Wire Section
    Item {
        id: weaponWireSection
        x: 0
        y: 55
        width: parent.width
        height: 40

        // Weapon Wire Label
        Text {
            x: 8
            y: 5
            text: "WEAPON WIRE"
            font.pixelSize: 12
            font.bold: true
            color: "#2E4F99"
        }

        // Weapon Wire Length Display
        Text {
            x: parent.width - 50
            y: 5
            text: root.weaponWireLength.toFixed(2)
            font.pixelSize: 12
            font.bold: true
            color: "#2E4F99"
        }

        // Weapon Wire Rod Background
        Rectangle {
            id: weaponWireBackground
            x: root.wireRodStartX
            y: 20
            width: root.wireRodWidth
            height: root.wireRodHeight
            color: "#E8E8E8"
            border.color: "#2E4F99"
            border.width: 1
        }

        // Weapon Wire Progress - Diagonal Segments
        Item {
            id: weaponWireProgressContainer
            x: root.wireRodStartX
            y: 20
            width: root.wireRodWidth
            height: root.wireRodHeight
            clip: true

            // Diagonal segments repeater for weapon wire (Red)
            Repeater {
                id: weaponWireRepeater
                model: Math.floor(root.wireRodWidth / 12)  // Number of diagonal segments

                Item {
                    x: index * 12
                    y: 0
                    width: 12
                    height: root.wireRodHeight
                    visible: index < (root.weaponWireProgress * weaponWireRepeater.model)

                    // Diagonal segment using Shape
                    Shape {
                        anchors.fill: parent
                        visible: parent.visible

                        ShapePath {
                            strokeWidth: 0
                            fillColor: "#F44336"  // Red color

                            startX: 1
                            startY: 1

                            PathLine { x: 9; y: 1 }                    // Top edge
                            PathLine { x: 11; y: root.wireRodHeight - 1 }  // Right diagonal
                            PathLine { x: 3; y: root.wireRodHeight - 1 }   // Bottom edge
                            PathLine { x: 1; y: 1 }                   // Left diagonal back to start
                        }

                        // Glow effect
                        ShapePath {
                            strokeWidth: 1
                            strokeColor: "#EF5350"  // Lighter red
                            fillColor: "transparent"

                            startX: 1
                            startY: 1

                            PathLine { x: 9; y: 1 }
                            PathLine { x: 11; y: root.wireRodHeight - 1 }
                            PathLine { x: 3; y: root.wireRodHeight - 1 }
                            PathLine { x: 1; y: 1 }
                        }
                    }

                    // Animation for each segment appearing
                    Behavior on visible {
                        SequentialAnimation {
                            PauseAnimation { duration: index * 30 }  // Staggered animation
                            PropertyAnimation {
                                target: parent
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: 150
                            }
                        }
                    }
                }
            }
        }

        // Weapon Wire tick marks
        Repeater {
            model: 8  // For 7.2m divided into segments
            Rectangle {
                x: root.wireRodStartX + (index * root.wireRodWidth / 7)
                y: 32
                width: 1
                height: 6
                color: "#2E4F99"
            }
        }
    }

    // Animation timers for simulating wire release
    Timer {
        id: osWireTimer
        interval: 50
        running: false
        repeat: true
        property real targetLength: 0
        onTriggered: {
            if (osWireLength < targetLength && osWireLength < maxWireLength) {
                osWireLength += 0.05
            } else {
                running = false
            }
        }
    }

    Timer {
        id: weaponWireTimer
        interval: 50
        running: false
        repeat: true
        property real targetLength: 0
        onTriggered: {
            if (weaponWireLength < targetLength && weaponWireLength < maxWireLength) {
                weaponWireLength += 0.05
            } else {
                running = false
            }
        }
    }

    // Public functions for external control
    function releaseOSWire() {
        var newLength = Math.min(osWireLength + Math.random() * 2 + 0.5, maxWireLength)
        osWireTimer.targetLength = newLength
        osWireTimer.start()
    }

    function releaseWeaponWire() {
        var newLength = Math.min(weaponWireLength + Math.random() * 2 + 0.5, maxWireLength)
        weaponWireTimer.targetLength = newLength
        weaponWireTimer.start()
    }

    function resetWires() {
        osWireTimer.stop()
        weaponWireTimer.stop()
        osWireLength = 0.0
        weaponWireLength = 0.0
    }

    // Functions to update wire lengths from external data
    function updateOSWireLength(length) {
        osWireLength = Math.max(0.0, Math.min(maxWireLength, length))
    }

    function updateWeaponWireLength(length) {
        weaponWireLength = Math.max(0.0, Math.min(maxWireLength, length))
    }

    function updateBothWires(osLength, weaponLength) {
        osWireLength = Math.max(0.0, Math.min(maxWireLength, osLength))
        weaponWireLength = Math.max(0.0, Math.min(maxWireLength, weaponLength))
    }

    function setMaxWireLength(maxLength) {
        maxWireLength = maxLength
    }
}
