import QtQuick

Window {
    width: 450
    height: 550
    visible: true
    title: qsTr("Hello World")
    color:"transparent"
    MainComponent{
        id:mainComponent
        anchors.centerIn:parent
    }
}
