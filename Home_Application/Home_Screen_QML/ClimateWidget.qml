import QtQuick 2.0

import QtGraphicalEffects 1.0
import QtQml 2.12

MouseArea {
    id: root
    property bool isFocus: false
    implicitWidth: 390
    implicitHeight: 340
    Rectangle {
        id: rectId
        anchors.centerIn: parent
        height:323
        width: 380
        opacity: 0.7
        color: "#111419"
    }
    onPressAndHold: {

       rectId.Drag.active = true
    }
    onPressed:  {
                root.state = "Pressed";
        }
    onReleased:{
        root.focus = true
        root.state = "Focus"
      /*  root.drag.target = null
        rectId.Drag.active = false;
        if(rectId.x>-408 && rectId.x<262){
            rectId.x = 1
           // media_replace3()
        }
        if(rectId.x<=-190 && rectId.x>-780){
           rectId.x = -408
            //media_replace2()
        }
        if(rectId.x>198){
           rectId.x = 405
        }*/
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        },
        State {
                name: "Dragging"
                ParentChange { target: root; parent: root.parent }
                PropertyChanges { target: root; x: dragArea.mouseX; y: dragArea.mouseY }
            }
    ]
   /* onFocusChanged: {

        if (root.focus == true ){
            console.log("climate focus")
            root.state = "Focus"
        }
        if(root.focus == false){
            console.log("Climate end focus")
            root.state = "Normal"
        }
    }*/

    Image {
        id: idBackgroud
        source: ""
        anchors.centerIn: rectId
        width: rectId.width+20
        height: rectId.height+10
    }

    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: 15
        text: "Climate"
        color: "white"
        font.pixelSize: 24
    }

    //Driver
    Text {
        id:textDriverId
        anchors.top:parent.top
        anchors.topMargin: 80
        anchors.left:  parent.left
        width: 150

        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        text: "DRIVER"
        color: "white"
    }

    Image {
        id: lineTextId1
        x:20
        y: 110
        anchors.horizontalCenter: textDriverId.horizontalCenter
        width: 120
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }

    Image {
        x: 60
        anchors.top: lineTextId1.top
        anchors.topMargin: 15
        width: 70
        height: 80
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }

    Image {
        id: arrow1_driver
        x: 40
        y:140
        width: 50
        height: 30

        source: "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png"
    }

    Image {
        id: arrow2_driver
        x: 20
        y:160
        width: 50
        height: 30
        source:  "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }

    Text {
        id: driver_temp
        anchors.horizontalCenter:  textDriverId.horizontalCenter
        y:230
        width: 150
        text: "LOW"
        color: "white"
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
    }

    //Passenger
    Text {
        id:textPassId
        anchors.top:parent.top
        anchors.topMargin: 80
        anchors.right:  parent.right
        width: 150
        font.pixelSize: 24
        text: "PASSENGER"
        color: "white"
        horizontalAlignment: Text.AlignHCenter
    }

    Image {
        id:lineTextId2
        x:80
        y: 110
        anchors.horizontalCenter: textPassId.horizontalCenter
        width: 130
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }

    Image {
        x: 300
        anchors.top: lineTextId2.top
        anchors.topMargin: 15
        width: 70
        height: 80
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }

    Image {
        id: arrow1_passenger
        x: 280
        y:140
        width: 50
        height: 30
        source:"qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png"
    }
    Image {
        id: arrow2_passenger
        x: 260
        y:160
        width: 50
        height: 30
        source:  "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }

    Text {
        id: passenger_temp
        anchors.horizontalCenter:  textPassId.horizontalCenter
        y:230
        width: 150
        text: "LOW"
        color: "white"
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
    }

    //Wind level
    Image {
       id: climateLevelId
       anchors.horizontalCenter: parent.horizontalCenter
        y:140
        width: 200
        height: 69
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_bg.png"
    }

    Image {
        id: fan_level
        x: 95
        y: 140
        width: 200
        height: 69
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
    }

    Connections{
        target: climateModel

        onTemp_driverChanged:{

            if (climateModel.driver_temp == 16.5) {
                driver_temp.text = "LOW"
            } else if (climateModel.driver_temp == 31.5) {
                driver_temp.text = "HIGH"
            } else {
                driver_temp.text = climateModel.driver_temp+"°C"
            }


        }
        onTemp_passengerChanged:{

            if (climateModel.passenger_temp == 16.5) {
                            passenger_temp.text = "LOW"
                        } else if (climateModel.passenger_temp == 31.5) {
                            passenger_temp.text = "HIGH"
                        } else {
                            passenger_temp.text = climateModel.passenger_temp+"°C"
                        }

        }
        onFan_speedChanged:{

            if (climateModel.fan_level < 1) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
            }
            else if (climateModel.fan_level < 10) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_0"+climateModel.fan_level+".png"
            } else {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_"+climateModel.fan_level+".png"
            }

        }
        onDriverWind_modeChanged:{
            console.log("Driver Wind Mode Change!"+climateModel.driver_wind_mode)
            arrow1_driver.source = climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            arrow2_driver.source = climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"

        }
        onPassengerWind_modeChanged:{

            arrow1_passenger.source = climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            arrow2_passenger.source = climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"

        }
        onSync_modeChanged:{

            syncId.color = !climateModel.sync_mode?"white":"gray"
        }
        onAuto_modeChanged:{

            autoId.color = !climateModel.auto_mode?"white":"gray"


    }
}
    //Fan
    Image {
        id: fanId
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: climateLevelId.bottom
        anchors.topMargin: 10
        width: 40
        height: 40
        source: "qrc:/Img/HomeScreen/widget_climate_ico_wind.png"
    }
    //Bottom

    Text {
        id: autoId
        anchors.top: driver_temp.bottom
        anchors.topMargin: 30
        width: 120
        horizontalAlignment: Text.AlignHCenter
        text: "AUTO"
        color: "white"
        font.pixelSize: 28
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: fanId.bottom
        anchors.topMargin: 20
        width: 120
        horizontalAlignment: Text.AlignHCenter
        text: "OUTSIDE"
        color: "white"
        font.pixelSize: 18
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: fanId.bottom
        anchors.topMargin: 45
        width: 120
        horizontalAlignment: Text.AlignHCenter
        text: "27.5°C"
        color: "white"
        font.pixelSize: 20
    }

    Text {
        id:syncId
        anchors.top: passenger_temp.bottom
        anchors.topMargin: 30
        anchors.right: parent.right

        width: 80
        horizontalAlignment: Text.AlignHCenter
        text: "SYNC"
        color: "white"
        font.pixelSize: 26
    }
    onIsFocusChanged: {
        root.focus = isFocus
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}

