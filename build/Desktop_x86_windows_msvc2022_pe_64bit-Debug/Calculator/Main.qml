import QtQuick
import QtQuick.Layouts
import Calculator

Window {
    id: mainWindow
    width: 600
    height: 1066
    visible: true
    color: "#024873"
    title: qsTr("Hello World")

    property string query: ""
    property string result: ""

    Backend {
        id: backend
        onQueryChanged: (newQuery) => {
                            query = newQuery
                        }
        onResultChanged: (newResult) => {
                             result = newResult
                         }
    }
    ColumnLayout {
        spacing: 0
        height: parent.height
        width: parent.width

        Rectangle {
            id: calculation
            bottomLeftRadius: 50
            bottomRightRadius: 50
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#04BFAD"
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Text {
                    padding:24
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    font.pointSize: height * 0.6
                    color: "white"
                    Layout.preferredHeight: 1
                    text: query
                }
                Text {
                    padding:24
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    font.pointSize: height * 0.3
                    color: "white"
                    Layout.preferredHeight: 1
                    text: result
                }
            }
        }
        Rectangle {
            id: controls
            Layout.preferredHeight: 3
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            color: "#024873"


            GridLayout {
                id: numbersGrid
                height: parent.height * 0.9
                width: parent.width * 0.9
                anchors.centerIn: parent
                rowSpacing: 24
                columnSpacing: 24
                columns: 4
                rows: 5
                ControlButton {
                    id: brackets
                    iconSource: "res/brackets.svg"
                    onClicked: {
                        backend.appendBrackets()
                    }
                }
                ControlButton {
                    id: plusMinus
                    iconSource: "res/power.svg"
                    onClicked: {
                        backend.appendToQuery("^")
                    }

                }
                ControlButton {
                    id: percent
                    iconSource: "res/percent.svg"
                    onClicked: {
                        backend.appendToQuery("%")
                    }
                }
                ControlButton {
                    id: divison
                    iconSource: "res/division.svg"
                    onClicked: {
                        backend.appendToQuery("/")
                    }
                }
                Repeater {
                    id: buttons7_9
                    model: 3
                    delegate:
                        DigitButton {
                        id: digitButton7_9
                        onClicked: {
                            backend.appendToQuery(digitButton7_9.value)
                        }
                    }
                    Component.onCompleted: {
                        for(var i = 0; i < 3; ++i) {
                            var button = buttons7_9.itemAt(i)
                            button.value = (i + 7)
                        }
                    }
                }
                ControlButton {
                    id: multiplication
                    iconSource: "res/multiplication.svg"
                    onClicked: {
                        backend.appendToQuery("*")
                    }
                }
                Repeater {
                    id: buttons4_6
                    model: 3
                    delegate:
                        DigitButton {
                        id: digitButton4_6
                        onClicked: {
                            backend.appendToQuery(digitButton4_6.value)
                        }
                    }
                    Component.onCompleted: {
                        for(var i = 0; i < 3; ++i) {
                            var button = buttons4_6.itemAt(i)
                            button.value = (i + 4)
                        }
                    }
                }
                ControlButton {
                    id: minus
                    iconSource: "res/minus.svg"
                    onClicked: {
                        backend.appendToQuery("-")
                    }
                }
                Repeater {
                    id: buttons1_3
                    model: 3
                    delegate:
                        DigitButton {
                        id: digitButton1_3
                        onClicked: {
                            backend.appendToQuery(digitButton1_3.value)
                        }
                    }
                    Component.onCompleted: {
                        for(var i = 0; i < 3; ++i) {
                            var button = buttons1_3.itemAt(i)
                            button.value = (i + 1)
                        }
                    }
                }

                ControlButton {
                    id: plus
                    iconSource: "res/plus.svg"
                    onClicked: {
                        backend.appendToQuery("+")
                    }
                }
                DigitButton {
                    id: clear
                    value: "C"
                    fontColor: "white"
                    backgroundColor: "#F25E5E"
                    onClicked: {
                        backend.clearQuery()
                    }
                }
                DigitButton {
                    id: digit0
                    value: "0"
                    onClicked: {
                        backend.appendToQuery("0")
                    }
                }
                DigitButton {
                    id: dot
                    value: "."
                    onClicked: {
                        backend.appendToQuery(".")
                    }
                }
                ControlButton {
                    id: equal
                    iconSource: "res/equal.svg"
                    backgroundColor: "#F7E425"
                    onClicked: {
                    }
                }
            }
        }
    }
}
