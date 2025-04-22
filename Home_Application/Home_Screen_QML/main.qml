import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
ApplicationWindow {
    width: 1230
    height: 730
    visible: true
   // visibility: "FullScreen"
    title: qsTr("Home Application")
    Image{
       id:backgroundId
       anchors.fill:parent
       source: "qrc:/Img/bg_full.png"
    }
    AppHeader{
        id:appHeaderId
        height: 70
        width: parent.width
        property bool isShowBackBtn:false
        onBntBackClicked: {
            stackView.pop()
            isShowBackBtn =  false
           // console.log("depth: "+stackView.depth)
        }
         Keys.onEscapePressed:{
             stackView.pop()
             isShowBackBtn =  false
         }

    }
    StackView {
        id: stackView
        width: 1230
        anchors.top: appHeaderId.bottom
        initialItem: HomeWidget{id:signalId}
        property bool inApp:false
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
            if(stackView.depth ===2){
                console.log("Depth:" +stackView.depth)
                appHeaderId.isShowBackBtn = true
            }
            else{
                console.log("Depth:" +stackView.depth)
              appHeaderId.isShowBackBtn = false
           }
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

  }

}


