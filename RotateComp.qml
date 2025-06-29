// import QtQuick 2.15
// import QtQuick.Controls 2.15

// Item {
//     id: root
//     width: 400
//     height: 600

//     property real currentValue: 90
//     property real orderedValue: 90
//     property real previousValue: 90

//     function setOrderedValue(newValue) {
//         previousValue = currentValue
//         orderedValue = newValue
//         rotationAnimation.start()
//     }

//     Rectangle {
//         anchors.fill: parent
//         color: "#f0f0f0"

//         // Header
//         Rectangle {
//             id: header
//             width: parent.width
//             height: 80
//             color: "#2c3e50"
//             border.color: "#34495e"
//             border.width: 2

//             Text {
//                 anchors.centerIn: parent
//                 text: "COURSE(~)"
//                 color: "white"
//                 font.pixelSize: 24
//                 font.bold: true
//             }
//         }

//         // Current Value Display
//         Rectangle {
//             id: currentValueContainer
//             anchors.top: header.bottom
//             anchors.topMargin: 10
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: parent.width - 20
//             height: 60
//             color: "white"
//             border.color: "#bdc3c7"
//             border.width: 2

//             Text {
//                 anchors.centerIn: parent
//                 text: "CURR. VAL. " + Math.round(root.currentValue) + "°"
//                 font.pixelSize: 18
//                 font.bold: true
//                 color: "#2c3e50"
//             }
//         }

//         // Dynamic Image Container with 360° Circle
//         Rectangle {
//             id: imageContainer
//             anchors.top: currentValueContainer.bottom
//             anchors.topMargin: 20
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: 300
//             height: 300
//             color: "white"
//             border.color: "#34495e"
//             border.width: 3
//             radius: 150

//             // 360° Degree Markings
//             Repeater {
//                 model: 36
//                 delegate: Rectangle {
//                     width: 2
//                     height: index % 9 === 0 ? 20 : 10
//                     color: "#2c3e50"
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     anchors.top: parent.top
//                     anchors.topMargin: 5
//                     transformOrigin: Item.Bottom
//                     rotation: index * 10

//                     Text {
//                         visible: index % 9 === 0
//                         text: (index * 10).toString()
//                         anchors.horizontalCenter: parent.horizontalCenter
//                         anchors.top: parent.bottom
//                         anchors.topMargin: 5
//                         font.pixelSize: 12
//                         color: "#2c3e50"
//                         rotation: -index * 10
//                     }
//                 }
//             }

//             // Center Circle
//             Rectangle {
//                 width: 20
//                 height: 20
//                 radius: 10
//                 color: "#e74c3c"
//                 anchors.centerIn: parent
//             }

//             // Missile Shape
//             Item {
//                 id: missile
//                 anchors.centerIn: parent
//                 width: 80
//                 height: 20
//                 rotation: root.currentValue - 90 // Subtract 90 to make 0° point up

//                 // Missile Body
//                 Rectangle {
//                     id: missileBody
//                     width: 60
//                     height: 8
//                     color: "#3498db"
//                     anchors.centerIn: parent
//                     radius: 4
//                 }

//                 // Missile Nose (Triangle)
//                 Canvas {
//                     id: missileNose
//                     width: 20
//                     height: 20
//                     anchors.left: missileBody.right
//                     anchors.leftMargin: -2
//                     anchors.verticalCenter: parent.verticalCenter

//                     onPaint: {
//                         var ctx = getContext("2d")
//                         ctx.clearRect(0, 0, width, height)
//                         ctx.fillStyle = "#2980b9"
//                         ctx.beginPath()
//                         ctx.moveTo(0, height/2)
//                         ctx.lineTo(width-5, 0)
//                         ctx.lineTo(width-5, height)
//                         ctx.closePath()
//                         ctx.fill()
//                     }
//                 }

//                 // Missile Fins
//                 Rectangle {
//                     width: 15
//                     height: 3
//                     color: "#2980b9"
//                     anchors.right: missileBody.left
//                     anchors.rightMargin: -5
//                     anchors.top: missileBody.top
//                     anchors.topMargin: -2
//                 }

//                 Rectangle {
//                     width: 15
//                     height: 3
//                     color: "#2980b9"
//                     anchors.right: missileBody.left
//                     anchors.rightMargin: -5
//                     anchors.bottom: missileBody.bottom
//                     anchors.bottomMargin: -2
//                 }
//             }

//             // Current Angle Indicator
//             Rectangle {
//                 width: 1
//                 height: 80
//                 color: "#e74c3c"
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 anchors.top: parent.top
//                 anchors.topMargin: 20
//                 transformOrigin: Item.Bottom
//                 rotation: root.currentValue
//                 opacity: 0.7
//             }

//             // Target Angle Indicator
//             Rectangle {
//                 width: 1
//                 height: 80
//                 color: "#27ae60"
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 anchors.top: parent.top
//                 anchors.topMargin: 20
//                 transformOrigin: Item.Bottom
//                 rotation: root.orderedValue
//                 opacity: 0.7
//             }
//         }

//         // Ordered Value Display and Input
//         Rectangle {
//             id: orderedValueContainer
//             anchors.top: imageContainer.bottom
//             anchors.topMargin: 20
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: parent.width - 20
//             height: 80
//             color: "white"
//             border.color: "#bdc3c7"
//             border.width: 2

//             Column {
//                 anchors.centerIn: parent
//                 spacing: 10

//                 Text {
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     text: "ORDERED VAL: " + Math.round(root.orderedValue) + "°"
//                     font.pixelSize: 16
//                     font.bold: true
//                     color: "#2c3e50"
//                 }

//                 Row {
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     spacing: 10

//                     SpinBox {
//                         id: angleInput
//                         from: 0
//                         to: 359
//                         value: root.orderedValue
//                         editable: true

//                         onValueChanged: {
//                             if (value !== root.orderedValue) {
//                                 root.setOrderedValue(value)
//                             }
//                         }
//                     }

//                     Button {
//                         text: "Set"
//                         onClicked: {
//                             root.setOrderedValue(angleInput.value)
//                         }
//                     }
//                 }
//             }
//         }

//         // Status Display
//         Rectangle {
//             anchors.top: orderedValueContainer.bottom
//             anchors.topMargin: 10
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: parent.width - 20
//             height: 40
//             color: rotationAnimation.running ? "#f39c12" : "#27ae60"
//             border.color: "#bdc3c7"
//             border.width: 1

//             Text {
//                 anchors.centerIn: parent
//                 text: rotationAnimation.running ? "ROTATING..." : "TARGET REACHED"
//                 color: "white"
//                 font.pixelSize: 14
//                 font.bold: true
//             }
//         }
//     }

//     // Rotation Animation
//     NumberAnimation {
//         id: rotationAnimation
//         target: root
//         property: "currentValue"
//         from: root.previousValue
//         to: root.orderedValue
//         duration: Math.abs(root.orderedValue - root.previousValue) * 50 // 10ms per degree
//         easing.type: Easing.InOutQuad

//         onRunningChanged: {
//             if (!running) {
//                 root.previousValue = root.currentValue
//             }
//         }
//     }
// }



// version 2.0
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 400
    height: 600

    property real currentValue: 90
    property real orderedValue: 90
    property real previousValue: 90

    function setOrderedValue(newValue) {
        previousValue = currentValue
        orderedValue = newValue
        rotationAnimation.start()
    }

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        // Header
        Rectangle {
            id: header
            width: parent.width
            height: 80
            color: "#2c3e50"
            border.color: "#34495e"
            border.width: 2

            Text {
                anchors.centerIn: parent
                text: "COURSE(~)"
                color: "white"
                font.pixelSize: 24
                font.bold: true
            }
        }

        // Current Value Display
        Rectangle {
            id: currentValueContainer
            anchors.top: header.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 20
            height: 60
            color: "white"
            border.color: "#bdc3c7"
            border.width: 2

            Text {
                anchors.centerIn: parent
                text: "CURR. VAL. " + Math.round(root.currentValue) + "°"
                font.pixelSize: 18
                font.bold: true
                color: "#2c3e50"
            }
        }

        // Dynamic Image Container with 360° Circle
        Rectangle {
            id: imageContainer
            anchors.top: currentValueContainer.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 300
            color: "white"
            border.color: "#34495e"
            border.width: 3
            radius: 150

            // Center Circle
            Rectangle {
                width: 20
                height: 20
                radius: 10
                color: "#e74c3c"
                anchors.centerIn: parent
            }

            // Missile Shape
            Item {
                id: missile
                anchors.centerIn: parent
                width: 80
                height: 20
                rotation: root.currentValue - 90 // Subtract 90 to make 0° point up

                // Missile Body
                Rectangle {
                    id: missileBody
                    width: 60
                    height: 8
                    color: "#3498db"
                    anchors.centerIn: parent
                    radius: 4
                }

                // Missile Nose (Triangle)
                Canvas {
                    id: missileNose
                    width: 20
                    height: 20
                    anchors.left: missileBody.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = "#2980b9"
                        ctx.beginPath()
                        ctx.moveTo(0, height/2)
                        ctx.lineTo(width-5, 0)
                        ctx.lineTo(width-5, height)
                        ctx.closePath()
                        ctx.fill()
                    }
                }

                // Missile Fins
                Rectangle {
                    width: 15
                    height: 3
                    color: "#2980b9"
                    anchors.right: missileBody.left
                    anchors.rightMargin: -5
                    anchors.top: missileBody.top
                    anchors.topMargin: -2
                }

                Rectangle {
                    width: 15
                    height: 3
                    color: "#2980b9"
                    anchors.right: missileBody.left
                    anchors.rightMargin: -5
                    anchors.bottom: missileBody.bottom
                    anchors.bottomMargin: -2
                }
            }

            // Current Angle Indicator
            Rectangle {
                width: 1
                height: 80
                // color: "#e74c3c"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                transformOrigin: Item.Bottom
                rotation: root.currentValue
                opacity: 0.7
            }

            // Target Angle Indicator
            Rectangle {
                width: 1
                height: 80
                // color: "#27ae60"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                transformOrigin: Item.Bottom
                rotation: root.orderedValue
                opacity: 0.7
            }
        }

        // Ordered Value Display and Input
        Rectangle {
            id: orderedValueContainer
            anchors.top: imageContainer.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 20
            height: 80
            color: "white"
            border.color: "#bdc3c7"
            border.width: 2

            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ORDERED VAL: " + Math.round(root.orderedValue) + "°"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    SpinBox {
                        id: angleInput
                        from: 0
                        to: 359
                        value: root.orderedValue
                        editable: true

                        onValueChanged: {
                            if (value !== root.orderedValue) {
                                root.setOrderedValue(value)
                            }
                        }
                    }

                    Button {
                        text: "Set"
                        onClicked: {
                            root.setOrderedValue(angleInput.value)
                        }
                    }
                }
            }
        }

        // Status Display
        Rectangle {
            anchors.top: orderedValueContainer.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 20
            height: 40
            color: rotationAnimation.running ? "#f39c12" : "#27ae60"
            border.color: "#bdc3c7"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: rotationAnimation.running ? "ROTATING..." : "TARGET REACHED"
                color: "white"
                font.pixelSize: 14
                font.bold: true
            }
        }
    }

    // Rotation Animation
    NumberAnimation {
        id: rotationAnimation
        target: root
        property: "currentValue"
        from: root.previousValue
        to: root.orderedValue
        duration: Math.abs(root.orderedValue - root.previousValue) * 50 // 10ms per degree
        easing.type: Easing.InOutQuad

        onRunningChanged: {
            if (!running) {
                root.previousValue = root.currentValue
            }
        }
    }
}

