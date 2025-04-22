import QtQuick 2.11
import QtQuick.Controls 2.4
import QtLocation 5.6
import QtPositioning 5.6
import QtQml 2.12

Item {
    id: root
    width: 1230
    height: 800

    // Animation to move the item
    SequentialAnimation {
        id: startAnimation
        running: true
        NumberAnimation {
            target: root
            property: "x"
            from: 1230
            to: 0
            duration: 200
        }
    }

    Rectangle {
        id: mapContainer
        anchors.centerIn: parent
        width: 1230
        height: 800

        Plugin {
            id: mapPlugin
            name: "osm" // Ensure this is supported in your Qt version
            parameters: [
                PluginParameter {
                    name: "osm.mapping.providersrepository.address"
                    value: "https://tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=5d31ec24e3af4714b422d84858b4900b"
                }
            ]
        }

        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(10.7873, 106.6665)
            zoomLevel: 16
            copyrightsVisible: false
            enabled: true

            MapQuickItem {
                id: marker
                anchorPoint.x: image.width / 2
                anchorPoint.y: image.height
                coordinate: QtPositioning.coordinate(10.7873, 106.6665)

                sourceItem: Image {
                    id: image
                    source: "qrc:/Img/Map/car_icon.png"
                }
            }
        }
    }

    Keys.onEscapePressed: {
        parent.pop()
        console.log("Key Escape Pressed")
    }
}
