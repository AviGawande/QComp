import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: mainContainer
    width: colLayout.implicitWidth
    height: colLayout.implicitHeight
    color: "transparent"
    border.color: "#1e1e1e"
    border.width: 1

    ColumnLayout {
        id: colLayout
        anchors.margins: 10
        anchors.centerIn: parent
        spacing: 10

        // header
        RowLayout {
            Layout.fillWidth: true
            Layout.margins: 10
            Text {
                Layout.fillWidth: true
                text: "Data Model Imports"
                font.pointSize: 14
                font.bold: true
                color: "#6a6a6a"
            }

            Rectangle {
                width: 20; height: 20; radius: 10
                border.color: "#3a3a3a"; border.width: 1
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "X"
                    font.pointSize: 10
                    color: "#6a6a6a"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Close button clicked")
                }
            }
        }

        ComboBox {
            id: affinityControl
            Layout.fillWidth: true
            Layout.margins: 10
            model: manualTrackData.affinityOptions
            onCurrentIndexChanged: manualTrackData.setAffinityIndex(currentIndex)
        }

        ComboBox {
            id: categoryComboBox
            Layout.fillWidth: true
            Layout.margins: 10
            model: manualTrackData.categoryOptions
            onCurrentIndexChanged: manualTrackData.setCategoryIndex(currentIndex)
        }

        ComboBox {
            id: typeComboBox
            Layout.fillWidth: true
            Layout.margins: 10
            model: manualTrackData.typeOptions
            onCurrentIndexChanged: manualTrackData.setTypeIndex(currentIndex)
        }
    }
}
