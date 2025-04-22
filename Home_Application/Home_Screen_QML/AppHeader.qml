import QtQuick 2.0
import QtQml 2.12
Item {
    signal bntBackClicked
    signal escPressed
     Rectangle{
          id:headerRectId
          anchors.fill:parent
          color: "#030304"
          BButton {
              anchors.left: parent.left
              icon: "qrc:/Img/StatusBar/btn_top_back"
              width: 100
              height: 70
              iconWidth: width
              iconHeight: height
              onClicked: bntBackClicked()
              visible: appHeaderId.isShowBackBtn 
          }
          Item {
              id: clockArea
              x:400
              width: 200
              height: parent.height
              Image {
                  anchors.left: parent.left
                  anchors.verticalCenter: clockTime.verticalCenter
                  height: clockTime.implicitHeight
                  source: "qrc:/Img/StatusBar/status_divider.png"
              }
              Text {
                  id: clockTime
                  text: "10:28"
                  color: "white"
                  font.pixelSize: 40
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  anchors.centerIn: parent
              }
              Image {
                  anchors.right: parent.right
                  anchors.verticalCenter: clockTime.verticalCenter
                  height: clockTime.implicitHeight
                  source: "qrc:/Img/StatusBar/status_divider.png"
              }
          }
          Item {
              id: dayArea
              anchors.left: clockArea.right
              width: 200
              height: parent.height
              Text {
                  id: day
                  text: "Jun. 24"
                  color: "white"
                  font.pixelSize: 40
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  anchors.centerIn: parent
              }
              Image {
                  anchors.right: parent.right
                  anchors.verticalCenter: day.verticalCenter
                  height: clockTime.implicitHeight
                  source: "qrc:/Img/StatusBar/status_divider.png"
              }
          }
          QtObject {
              id: time
              property var locale: Qt.locale()
              property date currentTime: new Date()

              Component.onCompleted: {
                  clockTime.text = currentTime.toLocaleTimeString(locale, "hh:mm");
                  day.text = currentTime.toLocaleDateString(locale, "MMM. dd");
              }
          }

          Timer{
              interval: 1000
              repeat: true
              running: true
              onTriggered: {
                  time.currentTime = new Date()
                  clockTime.text = time.currentTime.toLocaleTimeString(locale, "hh:mm");
                  day.text = time.currentTime.toLocaleDateString(locale, "MMM. dd");
              }

          }

     }
}
