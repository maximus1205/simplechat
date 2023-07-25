import QtQuick 2.0

Item {
    width: 212
    height: 43

    property string texts: "Text"
    property string textsx: "Text"
    property string time: "Time"

    Rectangle
    {
        x: 0
        y: 0
        width: 212
        height: 43
        radius: 10
        border.color: "#1ff54f"
        border.width: 1
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#060606"
            }

            GradientStop {
                position: 1
                color: "#011406"
            }
        }

        Text {
            id: text2
            x: 8
            y: 8
            width: 23
            height: 14
            color: "#ffffff"
            text: texts
            font.pixelSize: 12
            font.bold: true
        }

        Text {
            id: text3
            x: 8
            y: 25
            width: 23
            height: 14
            color: "#ffffff"
            text: textsx
            font.pixelSize: 12
        }

        Text {
            id: text1
            x: 181
            y: 25
            color: "#ffffff"
            text: time
            font.pixelSize: 10
        }

    }

}
