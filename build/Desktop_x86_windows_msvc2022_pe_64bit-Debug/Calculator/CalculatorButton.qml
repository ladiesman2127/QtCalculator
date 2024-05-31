import QtQuick
import QtQuick.Layouts

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    property int value
    Rectangle {
        height: parent.height
        width: parent.width
        color: "#04BFAD"
        radius: 0.5 * parent.width
        Text {
            text: value
        }
    }
}
