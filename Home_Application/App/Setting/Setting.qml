import QtQuick 2.11
import QtQuick.Controls 2.4
import QtLocation 5.6
import QtPositioning 5.6
import QtQml 2.12

Item {
    id: root
    width: 1230
    height: 90

    Item {
        id: startAnimation
        XAnimator{
            target: root
            from: 1230
            to: 0
            duration: 200
            running: true
        }
    }

    Image {
        id: headerItem
        source: "qrc:/App/ASM4/Image/title.png"
        width: 1230
        height: 90
        Text {
            id: headerTitleText
            text: qsTr("SETTINGS")
            anchors.centerIn: parent
            horizontalAlignment: Qt.Horizontal
            color: "white"
            font.pixelSize: 36
        }
    }

    Keys.onEscapePressed: {
        parent.pop()
        console.log("Key Escape Pressed")
    }
}
