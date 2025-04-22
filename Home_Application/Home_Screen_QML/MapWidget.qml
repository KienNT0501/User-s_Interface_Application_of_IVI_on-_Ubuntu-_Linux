import QtQml 2.12
import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12
MouseArea {
    id: root
    preventStealing: true
    propagateComposedEvents: true
    implicitWidth: 390
    implicitHeight: 340
    property bool isFocus: false
    Rectangle {
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
   Image {
        id: idBackgroud
        width: 405
        height: 340
        anchors.centerIn: root
        z:10
        source: ""
    }
    Item {
        id: map
        anchors.centerIn: root
        width: 390
        height: 320
        Plugin {
            id: mapPlugin
            name: "osm" //"osm" // , "esri", ...
            parameters: [
                       PluginParameter { name: "osm.mapping.providersrepository.address"; value: "https://tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=5d31ec24e3af4714b422d84858b4900b" }
                   ]
        }
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width/4
            anchorPoint.y: image.height
            coordinate: QtPositioning.coordinate(10.7873, 106.6665)

            sourceItem: Image {
                id: image
                source: "qrc:/Img/Map/car_icon.png"
            }
        }
        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(10.7873, 106.6665)
            zoomLevel: 14
            copyrightsVisible: false
            enabled: false
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }
    }
    onPressAndHold: {
    mapView.enabled = true
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
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Focus"

    }
    onIsFocusChanged: {
        root.focus = isFocus
        mapView.enabled = false
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}
