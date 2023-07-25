import QtQuick 2.0
import QtQuick.Window 2.12

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 251
        height: 103
        color: "#1e1e1e"
        radius: 20
        border.color: "#2ced39"
        border.width: 2

        CustomTextField {
            id: customTextField
            x: 19
            y: 33
            width: 121
            height: 24
            placeholderText: "Имя"
        }

        CustomTextField {
            id: customTextField1
            x: 19
            y: 63
            width: 121
            height: 24
            placeholderText: "id"
        }



        MouseArea {
            id: mouseArea1
            x: 211
            y: 7
            width: 28
            height: 26

            hoverEnabled: true

            onHoveredChanged:
            {
                if (mouseArea1.containsMouse)
                {
                    rectangle2.color = "#454444";
                }
                else
                {
                    rectangle2.color = "#3c3c3c";
                }
            }

            onClicked:{

            }

            Rectangle {
                id: rectangle2
                x: 0
                y: 1
                width: 28
                height: 27
                color: "#1e1e1e"
                radius: 3


                Image {
                    id: image
                    x: 0
                    y: 3
                    width: 29
                    height: 22
                    fillMode: Image.PreserveAspectFit
                    source: "images/close_icon.svg"
                    smooth: true
                    cache: true
                    mirror: false
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 153
            y: 44
            width: 86
            height: 25
            color: "#2ce014"
            radius: 10
            border.width: 1

            Text {
                id: text1
                x: 17
                y: 6
                color: "#ffffff"
                text: qsTr("Добавить")
                font.pixelSize: 12
            }
        }
    }
