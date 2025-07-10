CustomSpinBox {
    anchors.centerIn: parent
    value: 13.0
    stepSize: 1.0
    minValue: 0
    maxValue: 999
}

import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 220
    height: 50

    property int minValue: 0
    property int maxValue: 99999
    property real stepSize: 1.0
    property real value: 10.0

    function formatValue(val) {
        let intPart = Math.floor(val).toString().padStart(3, '0');
        let decimalPart = Math.round((val % 1) * 100).toString().padStart(2, '0');
        return intPart + "." + decimalPart;
    }

    Row {
        anchors.fill: parent
        spacing: 5

        Rectangle {
            width: parent.width
            height: parent.height
            color: "black"
            border.color: "blue"
            radius: 4

            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8
                padding: 8

                TextInput {
                    id: inputField
                    text: formatValue(value)
                    validator: DoubleValidator { bottom: minValue; top: maxValue }
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    width: 80
                    font.pixelSize: 18
                    color: "white"
                    selectionColor: "gray"
                    cursorVisible: true
                    onEditingFinished: {
                        let val = parseFloat(inputField.text)
                        if (!isNaN(val)) {
                            value = Math.max(minValue, Math.min(maxValue, val))
                        }
                        inputField.text = formatValue(value)
                    }
                    // remove unsupported 'background' property
                }

                Text {
                    text: "mts."
                    color: "white"
                    font.pixelSize: 18
                    verticalAlignment: Text.AlignVCenter
                }

                Column {
                    spacing: 2

                    Rectangle {
                        width: 20
                        height: 12
                        color: "white"
                        radius: 2

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (value + stepSize <= maxValue) {
                                    value += stepSize
                                    inputField.text = formatValue(value)
                                }
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "▲"
                            color: "black"
                            font.pixelSize: 10
                        }
                    }

                    Rectangle {
                        width: 20
                        height: 12
                        color: "white"
                        radius: 2

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (value - stepSize >= minValue) {
                                    value -= stepSize
                                    inputField.text = formatValue(value)
                                }
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "▼"
                            color: "black"
                            font.pixelSize: 10
                        }
                    }
                }
            }
        }
    }
}
