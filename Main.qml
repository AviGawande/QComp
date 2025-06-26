// import QtQuick 2.15
// import QtQuick.Window 2.15

// Window {
//     id: mainWindow
//     width: 640
//     height: 480
//     visible: true
//     title: qsTr("Hexagonal Circle Component")
//     color: "#f0f0f0"

//     // HexaComp {
//     //     id: hexaComp
//     //     anchors.centerIn: parent
//     // }

// }


import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Safety Application")

    SafetyPass {
        anchors.fill: parent
    }
}
