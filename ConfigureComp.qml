// image carousel 
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: "Image Carousel"

    property int currentIndex: 0
    property var images: [
        "qrc:/images/image1.jpg",
        "qrc:/images/image2.jpg",
        "qrc:/images/image3.jpg"
    ]

    Rectangle {
        anchors.fill: parent
        color: "black"

        // Image display
        Image {
            id: carouselImage
            anchors.centerIn: parent
            source: images[currentIndex]
            fillMode: Image.PreserveAspectFit
            width: parent.width * 0.8
            height: parent.height * 0.8
            smooth: true
        }

        // Previous Button (Left)
        Button {
            text: "\u25C0" // Unicode for left arrow
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: {
                currentIndex = (currentIndex - 1 + images.length) % images.length
            }
        }

        // Next Button (Right)
        Button {
            text: "\u25B6" // Unicode for right arrow
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: {
                currentIndex = (currentIndex + 1) % images.length
            }
        }

        // Page indicator
        Row {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15

            Repeater {
                model: images.length
                Rectangle {
                    width: 10
                    height: 10
                    radius: 5
                    color: index === currentIndex ? "white" : "gray"
                }
            }
        }
    }
}
