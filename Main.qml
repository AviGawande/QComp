// // import QtQuick 2.15
// // import QtQuick.Window 2.15

// // Window {
// //     id: mainWindow
// //     width: 640
// //     height: 480
// //     visible: true
// //     title: qsTr("Hexagonal Circle Component")
// //     color: "#f0f0f0"

// //     // HexaComp {
// //     //     id: hexaComp
// //     //     anchors.centerIn: parent
// //     // }

// // }


// import QtQuick 2.15
// import QtQuick.Controls 2.15

// ApplicationWindow {
//     id: window
//     width: 640
//     height: 480
//     visible: true
//     title: qsTr("Safety Application")

//     TorpedoFired{
//         anchors.centerIn:parent
//     }
// }

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 400
    height: 200
    visible: true
    title: "Torpedo Firing System"

    Column {
        anchors.centerIn: parent
        spacing: 20

        TorpedoFired {
            id: torpedoComponent
            width: 308
            height: 55
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Button {
                text: "Fire Torpedo"
                onClicked: torpedoComponent.fireTorpedo()
            }

            Button {
                text: "Move Target"
                onClicked: torpedoComponent.moveTarget()
            }

            Button {
                text: "Reset"
                onClicked: torpedoComponent.reset()
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Status: " + torpedoComponent.status
            font.pixelSize: 12
        }
    }
}

