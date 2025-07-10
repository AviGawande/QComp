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



/*
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Column {
    width: 300
    spacing: 10

    // Selection state
    property int selectedMode: 0  // 0 = Manual, 1 = Automatic

    Row {
        spacing: 20

        RadioButton {
            id: manualBtn
            text: "Manual Selection"
            checked: true
            onClicked: selectedMode = 0
        }

        RadioButton {
            id: autoBtn
            text: "Automatic Selection"
            onClicked: selectedMode = 1
        }
    }

    // Dynamic content switcher
    StackLayout {
        id: contentStack
        width: parent.width
        height: 100
        currentIndex: selectedMode

        // Manual Selection UI
        Rectangle {
            color: "#2e2e2e"
            radius: 4
            anchors.fill: parent

            Text {
                anchors.centerIn: parent
                text: "Manual Settings"
                color: "white"
            }
        }

        // Automatic Selection UI
        Rectangle {
            color: "#1e1e1e"
            radius: 4
            anchors.fill: parent

            Text {
                anchors.centerIn: parent
                text: "Automatic Settings"
                color: "white"
            }
        }
    }
}

*/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Column {
    width: 400
    spacing: 10

    property int selectedMode: 0  // 0 = Manual, 1 = Automatic

    Row {
        spacing: 20

        RadioButton {
            text: "Manual Selection"
            checked: true
            onClicked: selectedMode = 0
        }

        RadioButton {
            text: "Automatic Selection"
            onClicked: selectedMode = 1
        }
    }

    Rectangle {
        id: contentBox
        width: parent.width
        height: selectedMode === 0 ? 550 : 250
        color: "#222"
        radius: 8
        border.color: "gray"

        StackLayout {
            id: stack
            anchors.fill: parent
            currentIndex: selectedMode

            // Manual View (taller)
            Column {
                spacing: 10
                padding: 10

                Text { text: "Manual Field 1"; color: "white" }
                TextField { placeholderText: "Enter Value 1" }

                Text { text: "Manual Field 2"; color: "white" }
                TextField { placeholderText: "Enter Value 2" }

                Text { text: "Manual Field 3"; color: "white" }
                TextField { placeholderText: "Enter Value 3" }

                Rectangle {
                    width: 100; height: 40
                    color: "white"
                    Text {
                        anchors.centerIn: parent
                        text: "Your CustomSpinBox here"
                    }
                }
            }

            // Automatic View (shorter)
            Column {
                spacing: 10
                padding: 10

                Text { text: "Auto Field"; color: "white" }
                ComboBox {
                    model: ["Option A", "Option B"]
                }
            }
        }
    }
}

