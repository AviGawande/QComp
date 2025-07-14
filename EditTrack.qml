import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: mainContainer
    width: 400
    height: 300
        color: "#f0f0f0"
        border.color: "#88ffffff"
        border.width: 1

        // Mode toggle
        property bool editMode: false

        // Editable fields
        property string nameText: "machine-1"
        property string typeText: "EarthMover"
        property string categoryText: "Crane"
        property string timeText: "06:16:01"

        ColumnLayout {
            id: colLayout
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            // Header Row
            RowLayout {
                id: headerRow
                spacing: 10
                Layout.fillWidth: true

                Text {
                    text: "Edit Data"
                    font.bold: true
                    font.pointSize: 12
                    color: "#1e1e1e"
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                }

                Button {
                    id: crossButton
                    text: "✖"
                    font.pointSize: 14
                    background: Rectangle {
                        color: "transparent"
                    }
                    onClicked: Qt.quit()
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }

            // Content Box
            Rectangle {
                id: contentBox
                color: "white"
                border.color: "#cccccc"
                border.width: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 10

                GridLayout {
                    id: formField1
                    columns: 4
                    columnSpacing: 20
                    rowSpacing: 20
                    anchors.fill: parent
                    anchors.margins: 15

                    // Row 1
                    Text {
                        text: "Name:"
                        font.pointSize: 10
                        color: "#1e1e1e"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Loader {
                        id: nameLoader
                        sourceComponent: mainContainer.editMode ? textFieldComponent : textComponent
                        property string value: mainContainer.nameText
                        onLoaded: {
                            if (item) {
                                item.value = Qt.binding(function() { return mainContainer.nameText })
                                if (mainContainer.editMode && item.textChanged) {
                                    item.textChanged.connect(function() { mainContainer.nameText = item.text })
                                }
                            }
                        }
                        Layout.fillWidth: true
                    }

                    Text {
                        text: "Type:"
                        font.pointSize: 10
                        color: "#1e1e1e"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Loader {
                        id: typeLoader
                        sourceComponent: mainContainer.editMode ? textFieldComponent : textComponent
                        property string value: mainContainer.typeText
                        onLoaded: {
                            if (item) {
                                item.value = Qt.binding(function() { return mainContainer.typeText })
                                if (mainContainer.editMode && item.textChanged) {
                                    item.textChanged.connect(function() { mainContainer.typeText = item.text })
                                }
                            }
                        }
                        Layout.fillWidth: true
                    }

                    // Row 2
                    Text {
                        text: "Category:"
                        font.pointSize: 10
                        color: "#1e1e1e"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Loader {
                        id: categoryLoader
                        sourceComponent: mainContainer.editMode ? textFieldComponent : textComponent
                        property string value: mainContainer.categoryText
                        onLoaded: {
                            if (item) {
                                item.value = Qt.binding(function() { return mainContainer.categoryText })
                                if (mainContainer.editMode && item.textChanged) {
                                    item.textChanged.connect(function() { mainContainer.categoryText = item.text })
                                }
                            }
                        }
                        Layout.fillWidth: true
                    }

                    Text {
                        text: "Time:"
                        font.pointSize: 10
                        color: "#1e1e1e"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Loader {
                        id: timeLoader
                        sourceComponent: mainContainer.editMode ? timeFieldComponent : textComponent
                        property string value: mainContainer.timeText
                        onLoaded: {
                            if (item) {
                                item.value = Qt.binding(function() { return mainContainer.timeText })
                                if (mainContainer.editMode && item.timeChanged) {
                                    item.timeChanged.connect(function() { mainContainer.timeText = item.timeValue })
                                }
                            }
                        }
                        Layout.fillWidth: true
                    }
                }
            }

            // EDIT Button (View Mode)
            RowLayout {
                id: navigationButtons
                Layout.fillWidth: true
                spacing: 10
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignHCenter
                visible: !mainContainer.editMode

                Button {
                    id: editButton
                    text: "EDIT"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 35
                    onClicked: mainContainer.editMode = true

                    background: Rectangle {
                        anchors.fill: parent
                        color: editButton.down ? "#d32f2f" : "#1976d2"
                        border.color: "#0d47a1"
                        border.width: 1
                        radius: 4
                    }

                    contentItem: Text {
                        text: editButton.text
                        anchors.centerIn: parent
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                }
            }

            // RESET, CLOSE, SAVE Buttons (Edit Mode)
            RowLayout {
                id: closeSaveButtons
                Layout.fillWidth: true
                spacing: 10
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignHCenter
                visible: mainContainer.editMode

                Button {
                    id: resetButton
                    text: "RESET"
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 35
                    onClicked: {
                        mainContainer.nameText = "machine-1"
                        mainContainer.typeText = "EarthMover"
                        mainContainer.categoryText = "Crane"
                        mainContainer.timeText = "06:16:01"
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        border.color: "#ff0000"
                        border.width: 1
                        radius: 4
                    }

                    contentItem: Text {
                        text: resetButton.text
                        anchors.centerIn: parent
                        color: "red"
                        font.bold: true
                        font.pointSize: 10
                    }
                }

                Button {
                    id: closeButton
                    text: "CLOSE"
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 35
                    onClicked: mainContainer.editMode = false

                    background: Rectangle {
                        anchors.fill: parent
                        color: closeButton.down ? "#6a6a6a" : "#3A3A3A"
                        border.color: "#0d47a1"
                        border.width: 1
                        radius: 4
                    }

                    contentItem: Text {
                        text: closeButton.text
                        anchors.centerIn: parent
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                }

                Button {
                    id: saveButton
                    text: "SAVE"
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 35
                    onClicked: {
                        // Add save logic here
                        console.log("Saving data...")
                        mainContainer.editMode = false
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: saveButton.down ? "#66ffffff" : "#88ffffff"
                        border.color: "#0d47a1"
                        border.width: 1
                        radius: 4
                    }

                    contentItem: Text {
                        text: saveButton.text
                        anchors.centerIn: parent
                        color: "#1E1E1E"
                        font.bold: true
                        font.pointSize: 10
                    }
                }
            }
        }

        // Components for switching between view/edit
        Component {
            id: textComponent
            Text {
                property string value: ""
                text: value
                color: "#1e1e1e"
                font.pointSize: 10
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Component {
            id: textFieldComponent
            TextField {
                property string value: ""
                text: value
                font.pointSize: 10
                color: "#1e1e1e"
                background: Rectangle {
                    color: "white"
                    border.color: "#cccccc"
                    border.width: 1
                    radius: 3
                }
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Component {
            id: timeFieldComponent
            RowLayout {
                property string value: "06:16:01"
                property string timeValue: value
                signal timeChanged()

                spacing: 5

                function updateTime() {
                    var hours = hourSpinBox.value < 10 ? "0" + hourSpinBox.value : hourSpinBox.value.toString()
                    var minutes = minuteSpinBox.value < 10 ? "0" + minuteSpinBox.value : minuteSpinBox.value.toString()
                    var seconds = secondSpinBox.value < 10 ? "0" + secondSpinBox.value : secondSpinBox.value.toString()
                    timeValue = hours + ":" + minutes + ":" + seconds
                    timeChanged()
                }

                Component.onCompleted: {
                    var parts = value.split(":")
                    if (parts.length === 3) {
                        hourSpinBox.value = parseInt(parts[0])
                        minuteSpinBox.value = parseInt(parts[1])
                        secondSpinBox.value = parseInt(parts[2])
                    }
                }

                SpinBox {
                    id: hourSpinBox
                    from: 0
                    to: 23
                    value: 6
                    onValueChanged: parent.updateTime()

                    background: Rectangle {
                        color: "white"
                        border.color: "#cccccc"
                        border.width: 1
                        radius: 3
                    }

                    contentItem: TextInput {
                        text: (hourSpinBox.value < 10 ? "0" : "") + hourSpinBox.value
                        font.pointSize: 10
                        color: "#1e1e1e"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        readOnly: true
                    }
                }

                Text {
                    text: ":"
                    font.pointSize: 10
                    color: "#1e1e1e"
                    Layout.alignment: Qt.AlignVCenter
                }

                SpinBox {
                    id: minuteSpinBox
                    from: 0
                    to: 59
                    value: 16
                    onValueChanged: parent.updateTime()

                    background: Rectangle {
                        color: "white"
                        border.color: "#cccccc"
                        border.width: 1
                        radius: 3
                    }

                    contentItem: TextInput {
                        text: (minuteSpinBox.value < 10 ? "0" : "") + minuteSpinBox.value
                        font.pointSize: 10
                        color: "#1e1e1e"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        readOnly: true
                    }
                }

                Text {
                    text: ":"
                    font.pointSize: 10
                    color: "#1e1e1e"
                    Layout.alignment: Qt.AlignVCenter
                }

                SpinBox {
                    id: secondSpinBox
                    from: 0
                    to: 59
                    value: 1
                    onValueChanged: parent.updateTime()

                    background: Rectangle {
                        color: "white"
                        border.color: "#cccccc"
                        border.width: 1
                        radius: 3
                    }

                    contentItem: TextInput {
                        text: (secondSpinBox.value < 10 ? "0" : "") + secondSpinBox.value
                        font.pointSize: 10
                        color: "#1e1e1e"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        readOnly: true
                    }
                }

                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
