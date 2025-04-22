import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
//import myType.PlaylistModel 1.0
//import QtQuick.Layouts 1.3
    Item {
        //visible: true
        width: 1210
        height: 680
        //anchors.bottom: parent.bottom
        //visibility: "FullScreen"

        //Backgroud of Application
        Image {
            id: backgroud
            anchors.fill: parent
            source: "qrc:/App/ASM4/Image/background.png"
        }
        //Header
        AppHeader{
            id: headerItem
            width: parent.width
            height: 80
            onPlaylistOpen: {
               playlistId.drawerControlopen()
               mediaInfoControl.moveAway()
            }
            onPlaylistClose: {
               playlistId.drawerControlclose()
                mediaInfoControl.returnTo()
            }
            }


        //Playlist
         PlaylistView{
            id: playlistId
            y: headerItem.height+70
            width: 400
            height: parent.height - headerItem.height-70

            signal listViewClicked()
            onChangedPlaybutton:{

            }
        }


        //Media Info
        MediaInfoControl{
            id: mediaInfoControl
            anchors.top: headerItem.bottom
            anchors.right: playlistId.right
            anchors.left: parent.left
    //        anchors.leftMargin: ...
            anchors.bottom: parent.bottom
            signal moveAway()
            signal returnTo()
            signal artViewClicked()
            onMoveAway: {
                isRunning = true
            }
            onReturnTo: {
                isReturning = true
            }

        }
        Keys.onEscapePressed: {
            parent.pop()
            console.log("Key Escape Pressed")
        }
    }
