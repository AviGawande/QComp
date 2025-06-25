import QtQuick 2.15

Rectangle {
    id: root
    width: 300
    height: 260
    color: "transparent"
    border.color: "lightgray"
    border.width: 1

    property real circleRadius: 25
    property real circleBorderWidth: 2

    // Calculate hexagon center and radius
    property real centerX: width / 2
    property real centerY: height / 2
    property real hexRadius: Math.min(width, height) * 0.35

    // Simple state property - change this to control circles
    property var circleStates: [
        { id: "T1", active: true, clicked: false },
        { id: "T2", active: false, clicked: false },
        { id: "T3", active: true, clicked: false },
        { id: "T4", active: false, clicked: false },
        { id: "T5", active: true, clicked: false },
        { id: "T6", active: true, clicked: false }
    ]

    // Function to calculate position for each circle
    function getCirclePosition(index) {
        var angle = (index * 60) * Math.PI / 180
        var x = centerX + hexRadius * Math.cos(angle) - circleRadius
        var y = centerY + hexRadius * Math.sin(angle) - circleRadius
        return {x: x, y: y}
    }

    // Function to handle circle click
    function onCircleClick(index) {
        if (circleStates[index].active) {
            circleStates[index].clicked = !circleStates[index].clicked
            circleStatesChanged()
        }
    }

    // Repeater to create circles
    Repeater {
        model: 6

        Rectangle {
            width: circleRadius * 2
            height: circleRadius * 2
            radius: circleRadius
            border.color: circleStates[index].active ? "black" : "gray"
            border.width: circleBorderWidth
            x: getCirclePosition(index).x
            y: getCirclePosition(index).y

            opacity: {
                if (!circleStates[index].active) return 0.3
                if (circleStates[index].clicked) return 0.7
                return 1.0
            }

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: circleStates[index].active ? "black" : "#404040"
                }
                GradientStop {
                    position: 1.0
                    color: circleStates[index].active ? "blue" : "#606060"
                }
            }

            Text {
                text: circleStates[index].id
                anchors.centerIn: parent
                font.pixelSize: 12
                font.bold: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                enabled: circleStates[index].active
                onClicked: root.onCircleClick(index)
            }

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }
    }
}
