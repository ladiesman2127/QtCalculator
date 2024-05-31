import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: digitButton
    Layout.fillWidth: true
    Layout.fillHeight: true
    property string value
    property string backgroundColor: "#B0D1D8"
    property string fontColor: "#024873"
    signal clicked

    RoundButton {
        height: parent.height
        width: parent.width
        TapHandler {
            onTapped: clicked()
        }

        Rectangle {
            anchors.fill: parent
            Text {
                color: fontColor
                font.pixelSize: 0.5 * Math.min(parent.height, parent.width)
                anchors {
                    centerIn: parent
                }
                text: value
            }
            radius: 50 * parent.width
            color: backgroundColor
        }
    }
}
