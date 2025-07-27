import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: notificationContainer
    width: 400
    height: 500
    color: "transparent"

    // Weapon data property - this is where the data comes from
    property var weaponData: {
        "RANGE": {
            "Min Range": { value: 0, min: 0, max: 1000, step: 10 },
            "Max Range": { value: 500, min: 0, max: 2000, step: 25 },
            "Effective Range": { value: 300, min: 0, max: 1500, step: 15 }
        },
        "BR": {
            "Ballistic Rate": { value: 1.0, min: 0.1, max: 5.0, step: 0.1 },
            "Drop Rate": { value: 2.5, min: 0.0, max: 10.0, step: 0.25 },
            "Wind Drift": { value: 0.8, min: 0.0, max: 3.0, step: 0.1 }
        },
        "BRinv": {
            "Inverse BR": { value: 0.8, min: 0.1, max: 2.0, step: 0.05 },
            "Compensation": { value: 1.2, min: 0.5, max: 3.0, step: 0.1 },
            "Adjustment": { value: 0.5, min: 0.0, max: 2.0, step: 0.05 }
        },
        "AB": {
            "Angle Bias": { value: 45, min: 0, max: 90, step: 5 },
            "Elevation": { value: 15, min: -30, max: 60, step: 1 },
            "Azimuth": { value: 180, min: 0, max: 360, step: 5 }
        },
        "RB": {
            "Range Bias": { value: 100, min: 0, max: 500, step: 10 },
            "Distance Factor": { value: 1.5, min: 0.5, max: 3.0, step: 0.1 },
            "Correction": { value: 25, min: 0, max: 100, step: 5 }
        },
        "AW": {
            "Air Wind": { value: 5.0, min: 0.0, max: 20.0, step: 0.5 },
            "Wind Speed": { value: 10, min: 0, max: 50, step: 1 },
            "Wind Direction": { value: 90, min: 0, max: 360, step: 15 }
        }
    }

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "#99000000"
    }

    ColumnLayout {
        id: colLayout
        anchors.fill: parent
        anchors.margins: 10
        spacing: 0

        Rectangle {
            id: header
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "transparent"

            Text {
                id: titleText
                text: "WEAPON CONFIGURE"
                font.pixelSize: 20
                font.bold: true
                color: "white"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: closeButton
                text: "✕"
                font.pixelSize: 16
                color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -5
                    onClicked: {
                        console.log("Close button clicked")
                    }
                }
            }
        }

        // Custom tab bar
        Item {
            id: customTabBar
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            property int currentIndex: 0
            property var tabNames: ["RANGE", "BR", "BRinv", "AB", "RB", "AW"]

            Row {
                spacing: 0
                anchors.fill: parent

                Repeater {
                    model: customTabBar.tabNames

                    Item {
                        width: customTabBar.width / 6
                        height: customTabBar.height

                        Text {
                            text: modelData
                            color: customTabBar.currentIndex === index ? "#7FFF00" : "white"
                            font.pixelSize: 14
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: customTabBar.currentIndex = index
                        }
                    }
                }
            }
        }

        // Dynamic content area
        Rectangle {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 350  // Ensure minimum height
            color: "transparent"
            Layout.topMargin: 10

            ScrollView {
                anchors.fill: parent
                anchors.margins: 10
                clip: true  // Enable clipping for proper scrolling

                ColumnLayout {
                    width: contentArea.width - 20
                    height: Math.max(contentArea.height - 20, implicitHeight)  // Ensure consistent height
                    spacing: 15

                    Text {
                        text: customTabBar.tabNames[customTabBar.currentIndex] + " Configuration"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#7FFF00"
                        Layout.fillWidth: true
                    }

                    Repeater {
                        model: {
                            var currentTab = customTabBar.tabNames[customTabBar.currentIndex]
                            var data = weaponData[currentTab]
                            return Object.keys(data || {})
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60

                            Rectangle {
                                anchors.fill: parent
                                color: "#22FFFFFF"
                                radius: 5
                                border.color: "#44FFFFFF"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10

                                    Text {
                                        text: modelData
                                        color: "white"
                                        font.pixelSize: 14
                                        Layout.preferredWidth: 120
                                        Layout.alignment: Qt.AlignVCenter
                                    }

                                    SpinBox {
                                        id: spinBox
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 35

                                        property var currentData: {
                                            var currentTab = customTabBar.tabNames[customTabBar.currentIndex]
                                            return weaponData[currentTab][modelData] || {}
                                        }

                                        from: (currentData.min || 0) * 100
                                        to: (currentData.max || 100) * 100
                                        stepSize: (currentData.step || 1) * 100
                                        value: (currentData.value || 0) * 100

                                        validator: DoubleValidator {
                                            bottom: spinBox.from / 100
                                            top: spinBox.to / 100
                                            decimals: 2
                                        }

                                        textFromValue: function(value, locale) {
                                            return Number(value / 100).toFixed(2)
                                        }

                                        valueFromText: function(text, locale) {
                                            return Number.fromLocaleString(locale, text) * 100
                                        }

                                        onValueChanged: {
                                            // Update the weapon data when value changes
                                            var currentTab = customTabBar.tabNames[customTabBar.currentIndex]
                                            if (weaponData[currentTab] && weaponData[currentTab][modelData]) {
                                                weaponData[currentTab][modelData].value = value / 100
                                                console.log("Updated", currentTab, modelData, "to", value / 100)
                                            }
                                        }

                                        background: Rectangle {
                                            color: "#33FFFFFF"
                                            border.color: spinBox.activeFocus ? "#7FFF00" : "#66FFFFFF"
                                            border.width: 2
                                            radius: 3
                                        }

                                        contentItem: TextInput {
                                            text: spinBox.textFromValue(spinBox.value, spinBox.locale)
                                            font: spinBox.font
                                            color: "white"
                                            selectionColor: "#7FFF00"
                                            selectedTextColor: "black"
                                            horizontalAlignment: Qt.AlignHCenter
                                            verticalAlignment: Qt.AlignVCenter
                                            readOnly: !spinBox.editable
                                            validator: spinBox.validator
                                            inputMethodHints: Qt.ImhFormattedNumbersOnly
                                        }

                                        up.indicator: Rectangle {
                                            x: spinBox.mirrored ? 0 : parent.width - width
                                            height: parent.height / 2
                                            implicitWidth: 20
                                            color: spinBox.up.pressed ? "#7FFF00" : "#44FFFFFF"
                                            border.color: "#66FFFFFF"
                                            radius: 2

                                            Text {
                                                text: "▲"
                                                font.pixelSize: 8
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }

                                        down.indicator: Rectangle {
                                            x: spinBox.mirrored ? 0 : parent.width - width
                                            y: parent.height / 2
                                            height: parent.height / 2
                                            implicitWidth: 20
                                            color: spinBox.down.pressed ? "#7FFF00" : "#44FFFFFF"
                                            border.color: "#66FFFFFF"
                                            radius: 2

                                            Text {
                                                text: "▼"
                                                font.pixelSize: 8
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }

                                    Text {
                                        text: {
                                            var currentTab = customTabBar.tabNames[customTabBar.currentIndex]
                                            var data = weaponData[currentTab][modelData]
                                            return "(" + (data?.min || 0) + "-" + (data?.max || 100) + ")"
                                        }
                                        color: "#AAAAAA"
                                        font.pixelSize: 10
                                        Layout.preferredWidth: 60
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }
                            }
                        }
                    }

                    // Spacer item to fill remaining space and maintain consistent height
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 20
                    }
                }
            }
        }
    }
}
