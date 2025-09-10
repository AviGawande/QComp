import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: customSpinBox
    width: 200
    height: 40
    border.color: "#6366f1"
    border.width: 2
    radius: 4

    // Properties
    property real value: 0.0
    property real stepSize: 1.0
    property string unit: "metre"
    property real minimumValue: -999999
    property real maximumValue: 999999
    property int decimals: 2

    // Icon properties for customization
    property string upIconSource: ""
    property string downIconSource: ""

    // Internal property to track if we're updating from code
    property bool updatingFromCode: false

    function updateValue(newValue) {
        var clampedValue = Math.max(minimumValue, Math.min(maximumValue, newValue))
        updatingFromCode = true
        value = clampedValue
        valueInput.text = value.toFixed(decimals)
        updatingFromCode = false
    }

    function clampValue(val) {
        return Math.max(minimumValue, Math.min(maximumValue, val))
    }

    // Watch for external value changes
    onValueChanged: {
        if (!updatingFromCode && !valueInput.activeFocus) {
            valueInput.text = value.toFixed(decimals)
        }
    }

    Row {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 4

        // Value input field
        TextInput {
            id: valueInput
            width: parent.width - unitLabel.width - buttonColumn.width - 8
            height: parent.height
            text: customSpinBox.value.toFixed(customSpinBox.decimals)
            font.pixelSize: 14
            verticalAlignment: TextInput.AlignVCenter
            selectByMouse: true

            validator: DoubleValidator {
                bottom: customSpinBox.minimumValue
                top: customSpinBox.maximumValue
                decimals: customSpinBox.decimals
                notation: DoubleValidator.StandardNotation
            }

            // Remove the onTextChanged handler that was causing issues
            // and only validate on editing finished
            onEditingFinished: {
                var inputText = text.trim()
                var newValue = parseFloat(inputText)

                if (isNaN(newValue) || inputText === "") {
                    // Reset to current value if invalid input
                    text = customSpinBox.value.toFixed(customSpinBox.decimals)
                } else {
                    // Clamp the value and update
                    var clampedValue = customSpinBox.clampValue(newValue)
                    customSpinBox.updateValue(clampedValue)

                    // If the value was clamped, update the display immediately
                    if (clampedValue !== newValue) {
                        text = clampedValue.toFixed(customSpinBox.decimals)
                    }
                }
            }

            // Handle focus loss (when user clicks elsewhere)
            onActiveFocusChanged: {
                if (!activeFocus) {
                    var inputText = text.trim()
                    var newValue = parseFloat(inputText)

                    if (isNaN(newValue) || inputText === "") {
                        text = customSpinBox.value.toFixed(customSpinBox.decimals)
                    } else {
                        var clampedValue = customSpinBox.clampValue(newValue)
                        customSpinBox.updateValue(clampedValue)
                        text = clampedValue.toFixed(customSpinBox.decimals)
                    }
                }
            }

            Keys.onUpPressed: {
                var newValue = customSpinBox.clampValue(customSpinBox.value + customSpinBox.stepSize)
                customSpinBox.updateValue(newValue)
            }

            Keys.onDownPressed: {
                var newValue = customSpinBox.clampValue(customSpinBox.value - customSpinBox.stepSize)
                customSpinBox.updateValue(newValue)
            }

            Keys.onReturnPressed: {
                focus = false // Trigger onActiveFocusChanged
            }

            Keys.onEnterPressed: {
                focus = false // Trigger onActiveFocusChanged
            }
        }

        // Unit label
        Text {
            id: unitLabel
            text: customSpinBox.unit
            width: contentWidth + 8
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#666666"
            font.pixelSize: 12
        }

        // Increment/Decrement buttons
        Column {
            id: buttonColumn
            width: 20
            height: parent.height
            spacing: 0

            // Increment button
            Rectangle {
                id: incrementButton
                width: parent.width
                height: parent.height / 2
                color: incrementMouse.pressed ? "#e5e7eb" : (incrementMouse.containsMouse ? "#f3f4f6" : "transparent")
                border.color: "#d1d5db"
                border.width: 1

                // Custom icon or default arrow
                Item {
                    anchors.centerIn: parent
                    width: 12
                    height: 12

                    Image {
                        id: upIcon
                        anchors.centerIn: parent
                        source: customSpinBox.upIconSource
                        width: parent.width
                        height: parent.height
                        visible: customSpinBox.upIconSource !== ""
                    }

                    // Default up arrow if no custom icon
                    Canvas {
                        anchors.centerIn: parent
                        width: 8
                        height: 6
                        visible: customSpinBox.upIconSource === ""

                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)
                            ctx.fillStyle = "#374151"
                            ctx.beginPath()
                            ctx.moveTo(width/2, 0)
                            ctx.lineTo(0, height)
                            ctx.lineTo(width, height)
                            ctx.closePath()
                            ctx.fill()
                        }
                    }
                }

                MouseArea {
                    id: incrementMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        // Force focus away from input to ensure value is synced
                        valueInput.focus = false
                        var newValue = customSpinBox.clampValue(customSpinBox.value + customSpinBox.stepSize)
                        customSpinBox.updateValue(newValue)
                    }
                }
            }

            // Decrement button
            Rectangle {
                id: decrementButton
                width: parent.width
                height: parent.height / 2
                color: decrementMouse.pressed ? "#e5e7eb" : (decrementMouse.containsMouse ? "#f3f4f6" : "transparent")
                border.color: "#d1d5db"
                border.width: 1

                // Custom icon or default arrow
                Item {
                    anchors.centerIn: parent
                    width: 12
                    height: 12

                    Image {
                        id: downIcon
                        anchors.centerIn: parent
                        source: customSpinBox.downIconSource
                        width: parent.width
                        height: parent.height
                        visible: customSpinBox.downIconSource !== ""
                    }

                    // Default down arrow if no custom icon
                    Canvas {
                        anchors.centerIn: parent
                        width: 8
                        height: 6
                        visible: customSpinBox.downIconSource === ""
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)
                            ctx.fillStyle = "#374151"
                            ctx.beginPath()
                            ctx.moveTo(0, 0)
                            ctx.lineTo(width, 0)
                            ctx.lineTo(width/2, height)
                            ctx.closePath()
                            ctx.fill()
                        }
                    }
                }

                MouseArea {
                    id: decrementMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        // Force focus away from input to ensure value is synced
                        valueInput.focus = false
                        var newValue = customSpinBox.clampValue(customSpinBox.value - customSpinBox.stepSize)
                        customSpinBox.updateValue(newValue)
                    }
                }
            }
        }
    }
}
