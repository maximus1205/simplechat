import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Shapes 1.12

Window {
    id: window
    width: 640
    height: 480
    visible: true
    color: "#00000000"
    title: qsTr("Simple Chat")

    flags: Qt.FramelessWindowHint | Qt.Window

    property string zxc: ""
    property string zx2c: ""
    property string ivd: ""

    property string choosenname: "";
    property string choosenid: "";

    Timer
    {
        id: zxczxc2; repeat: false; interval: 1; running: true
        onTriggered:
        {
            tcp.send(text5.text);
            tcp.conxnect();

            while (tcp.next())
            {
                var newMsg = {};
                newMsg.name = tcp.readName();
                newMsg.id = "id: "+ tcp.readID();
                tcp.add(newMsg.name, newMsg.id);
                listModel2.append(newMsg);
            }
        }
    }



    Timer
    {
        repeat: true; interval: 1; running: true
        onTriggered:
        {
            zxc = tcp.readData();

            if(zxc != "" && zxc != zx2c)
            {

                ivd = tcp.getparsID();

                text2.text = tcp.containsname(ivd);

                var newMsg = {};
                newMsg.text = zxc;
                newMsg.avtor = tcp.containsname(ivd);
                newMsg.time = Qt.formatTime(new Date(), "hh:mm");
                listModel.append(newMsg);
                rectangle3.visible = true;
                zx2c = zxc;

                text2.text = tcp.containsname(ivd);
                console.log(tcp.containsname(ivd));
                tcp.setparsID(tcp.getparsID());

            }
        }
    }


    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 640
        height: 480
        radius: 25
        border.color: "#1df237"
        border.width: 3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#191a19"
            }

            GradientStop {
                position: 1
                color: "#0b561c"
            }
        }
        clip: false


        Rectangle {
            id: rectangle1
            x: 8
            y: 46
            width: 212
            height: 378
            color: "#303030"
            radius: 15
            border.color: "#1df237"
            border.width: 2
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#303030"
                }

                GradientStop {
                    position: 1
                    color: "#03240a"
                }
            }
            clip: false

            ListView {
                id: listView1
                x: 8
                y: 52
                width: 195
                height: 278
                spacing: 6
                clip: true
                model: listModel2

                delegate:

                    MouseArea{

                    width: 177
                    height: 44
                    hoverEnabled: true

                    onHoveredChanged: {

                        if (containsMouse)
                        {
                            rec2.color = "#4f4f4f"
                        }
                        else
                        {
                            rec2.color = "#414141"
                        }

                    }

                    onPressed: {

                        rec2.color = "#212121";
                    }

                    onReleased: {
                        rec2.color = "#414141";
                        rectangle3.visible = true;
                        tcp.setparsID(model.id);
                        text2.text = model.name;
                        listModel.clear();


                        choosenname = model.name;
                        choosenid = model.id;
                    }

                    Rectangle {

                        id: rec2
                        width: 177
                        height: 44
                        color: "#414141"
                        radius: 14
                        border.color: "#2df851"
                        border.width: 1

                        Text {
                            x: 17
                            y: 0
                            color: "#4dde6b"
                            text: model.name
                            font.pixelSize: 15
                        }

                        Text {
                            x: 19
                            y: 22
                            color: "#f9fcfa"
                            text: model.id
                            font.pixelSize: 12
                        }
                    }
                }

                ListModel
                {
                    id: listModel2
                }

            }

            MouseArea {
                id: mouseArea4
                x: 15
                y: 336
                width: 87
                height: 34

                Rectangle {
                    id: rectangle6
                    x: 0
                    y: 0
                    width: 87
                    height: 34
                    color: "#1b1c1b"
                    radius: 5
                    border.color: "#2ced39"

                    Text {
                        id: text6
                        x: 17
                        y: 10
                        color: "#ffffff"
                        text: qsTr("Добавить")
                        font.pixelSize: 12
                    }
                }

                onPressed:
                {
                    rectangle6.color = "#272927";
                }

                onReleased:
                {
                    rectangle6.color = "#1b1c1b";
                    rectangle4342.visible = true;
                }
            }



            MouseArea {
                id: mouseArea5
                x: 108
                y: 336
                width: 87
                height: 34
                Rectangle {
                    id: rectangle9
                    x: 0
                    y: 0
                    width: 87
                    height: 34
                    color: "#1b1c1b"
                    radius: 5
                    border.color: "#2ced39"
                    Text {
                        id: text7
                        x: 17
                        y: 10
                        color: "#ffffff"
                        text: qsTr("Удалить")
                        font.pixelSize: 12
                    }
                }

                onPressed:
                {
                    rectangle9.color = "#272927";
                }

                onReleased:
                {
                    rectangle9.color = "#1b1c1b";
                    tcp.remove(choosenname, choosenid);
                    listModel2.clear();
                    zxczxc2.running = true;
                    rectangle3.visible = false;
                    text2.text = tcp.containsname(ivd);
                }
            }
        }


        Text {
            id: text1
            x: 28
            y: 53
            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Segoe UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Segoe UI Black'; font-size:20pt; color:#ffffff;\">Контакты</span></p></body></html>"
            font.pixelSize: 12
            textFormat: Text.RichText
        }


        Rectangle {
            id: rectangle3
            x: 221
            y: 46
            width: 402
            height: 426
            visible: false
            color: "#212121"
            radius: 10
            border.color: "#1df237"
            border.width: 2
            clip: false
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#212121"
                }

                GradientStop {
                    position: 1
                    color: "#021306"
                }
            }

            CustomTextField {
                id: customTextField
                x: 14
                y: 375
                width: 320
                height: 43
                font.pointSize: 13
            }


            Rectangle {
                id: rectangle7
                x: 8
                y: 8
                width: 375
                height: 44
                color: "#3f3d3d"
                radius: 10
                border.color: "#1df237"
                border.width: 2
                clip: true
            }
            Text {
                id: text2
                x: 33
                y: 15
                color: "#26bf0d"
                text: qsTr("Максим")
                font.pixelSize: 22
                font.bold: true
                font.family: "Arial"
            }

            ListView {
                id: listView
                x: 14
                y: 109
                width: 213
                height: 197
                spacing: 7
                model: listModel
                delegate: Message{
                    height: 43
                    width: ListView.view.width
                    textsx: model.text
                    time: model.time
                    texts: model.avtor
                }

                onCountChanged: {
                    positionTimer.start();
                }

                ListModel
                {
                    id: listModel
                }

            }

            MouseArea {
                id: mouseArea3
                x: 341
                y: 375
                width: 55
                height: 43

                onHoveredChanged:
                {
                    if (mouseArea3.containsMouse)
                    {
                        rectangle5.color = "#454444";
                    }
                    else
                    {
                        rectangle5.color = "#3c3c3c";
                    }
                }

                onReleased:
                {
                    tcp.send(customTextField.text);
                    var newMsg = {};
                    newMsg.text = customTextField.text;
                    newMsg.avtor = "Вы";
                    newMsg.time = Qt.formatTime(new Date(), "hh:mm");
                    listModel.append(newMsg);
                    customTextField.text = "";
                }

                Rectangle {
                    id: rectangle5
                    x: 0
                    y: -3
                    width: 53
                    height: 46
                    color: "#3c3c3c"
                    radius: 3
                    Image {
                        id: image2
                        x: 0
                        y: 0
                        width: 53
                        height: 46
                        source: "images/free-icon-send-8084272.png"
                        cache: true
                        autoTransform: false
                        mipmap: false
                        fillMode: Image.PreserveAspectFit
                        mirror: false
                        smooth: true
                    }
                }
                hoverEnabled: true
            }
        }

        Timer {
            id: positionTimer
            interval: 200
            repeat: false
            onTriggered: listView.positionViewAtIndex(listView.count - 1, ListView.Visible)
        }






        Text {
            id: text4
            x: 20
            y: 12
            color: "#1df237"
            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Segoe UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Arial Black'; font-size:11pt; color:#0cfe14;\">Simple Chat 1.0.0</span></p></body></html>"
            font.pixelSize: 12
            textFormat: Text.RichText
        }


        MouseArea {
            id: mouseArea1
            x: 596
            y: 10
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
                Qt.quit();
            }

            Rectangle {
                id: rectangle2
                x: 0
                y: 1
                width: 28
                height: 27
                color: "#3c3c3c"
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
                    autoTransform: false
                    mirror: false
                    mipmap: false
                }
            }
        }

        MouseArea {
            id: mouseArea2
            x: 562
            y: 11
            width: 28
            height: 26
            onClicked:{
                window.showMinimized();
            }
            onHoveredChanged:
            {
                if (mouseArea2.containsMouse)
                {
                    rectangle4.color = "#454444";
                }
                else
                {
                    rectangle4.color = "#3c3c3c";
                }
            }

            Rectangle {
                id: rectangle4
                x: 0
                y: 1
                width: 28
                height: 27
                color: "#3c3c3c"
                radius: 3
                Image {
                    id: image1
                    x: 0
                    y: 3
                    width: 29
                    height: 22
                    source: "images/minimize_icon.svg"
                    cache: true
                    autoTransform: false
                    mipmap: false
                    fillMode: Image.PreserveAspectFit
                    mirror: false
                    smooth: true
                }
            }
            hoverEnabled: true
        }

        Rectangle {
            id: rectangle8
            x: 8
            y: 430
            width: 212
            height: 42
            radius: 15
            border.color: "#1df237"
            border.width: 2
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#19a236"
                }

                GradientStop {
                    position: 1
                    color: "#1089cd"
                }
            }

            Text {
                id: text5
                x: 13
                y: 12
                color: "#ffffff"
                text: qsTr("Ваш id: 10")
                font.pixelSize: 16
                font.bold: true
                font.family: "Verdana"
            }
        }


    }

    Rectangle {
        id: rectangle4342
        x: 195
        y: 189
        width: 251
        height: 103
        visible: false
        color: "#1e1e1e"
        radius: 20
        border.color: "#2ced39"
        border.width: 2

        CustomTextField {
            id: customTextField222
            x: 19
            y: 33
            width: 121
            height: 24
            placeholderText: "Имя"
        }

        CustomTextField {
            id: customTextField122
            x: 19
            y: 63
            width: 121
            height: 24
            placeholderText: "id"
        }



        MouseArea {
            id: mouseArea1344
            x: 211
            y: 7
            width: 28
            height: 26

            hoverEnabled: true

            onHoveredChanged:
            {
                if (mouseArea1344.containsMouse)
                {
                    rectangle299.color = "#454444";
                }
                else
                {
                    rectangle299.color = "#3c3c3c";
                }
            }

            onClicked:{
                rectangle4342.visible = false;
            }

            Rectangle {
                id: rectangle299
                x: 0
                y: 1
                width: 28
                height: 27
                color: "#1e1e1e"
                radius: 3


                Image {
                    id: image222
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

        MouseArea {
            id: mouseArea6
            x: 153
            y: 44
            width: 86
            height: 25

            Rectangle {
                id: rectangle120
                x: 0
                y: 0
                width: 86
                height: 25
                color: "#2ce014"
                radius: 10
                border.width: 1

                Text {
                    id: text1400
                    x: 17
                    y: 6
                    color: "#ffffff"
                    text: qsTr("Добавить")
                    font.pixelSize: 12
                }
            }

            onPressed: {
                rectangle120.color = "#1f9c0e";
            }

            onReleased: {
                rectangle120.color = "#2ce014";
                var newMsg = {};
                newMsg.name = customTextField222.text;
                newMsg.id = "id: " + customTextField122.text;
                listModel2.append(newMsg);
                tcp.dbSend(customTextField222.text, customTextField122.text);
                customTextField222.text = "";
                customTextField122.text = "";
                rectangle4342.visible = false;

            }
        }
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: 538
        height: 44

        onPressed:
        {
            window.startSystemMove();
        }
    }

}




