import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Calculator

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    property Backend bend
    property string iconSource
    property string backgroundColor: "#0889A6"
    property string fontColor: "white"
    signal clicked



    RoundButton {
        height: parent.height
        width: parent.width
        TapHandler {
            onTapped: clicked()
        }

        Rectangle {
            anchors.fill: parent
            radius: 50 * parent.width
            color: backgroundColor
            Image {
                source: iconSource
                anchors.centerIn: parent
                width: Math.min(parent.height, parent.width) * 0.5
                height: Math.min(parent.height, parent.width) * 0.5
            }
        }
    }
}

