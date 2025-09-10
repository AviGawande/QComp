https://claude.ai/chat/3c672868-2fb4-4f27-8175-c661ece8614c

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 400
    height: 300
    visible: true
    title: "Custom SpinBox Demo"

    Column {
        anchors.centerIn: parent
        spacing: 20

        CustomSpinBox {
            value: 34.2
            unit: "metre"
            stepSize: 0.1
            decimals: 1
            minimumValue: 0
            maximumValue: 999.9
            // upIconSource: "path/to/your/up-icon.svg"
            // downIconSource: "path/to/your/down-icon.svg"
        }

        CustomSpinBox {
            value: 5
            unit: "degree"
            stepSize: 0.1
            decimals: 1
            minimumValue: 0
            maximumValue: 359.9
        }

        CustomSpinBox {
            value: 250.5
            unit: "range"
            stepSize: 0.1
            decimals: 1
            minimumValue: 0
            maximumValue: 99.9
        }
    }
}
