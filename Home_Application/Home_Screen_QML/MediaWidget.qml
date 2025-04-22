import QtQuick 2.0
import QtGraphicalEffects 1.0


MouseArea {
    id: root
    property bool isFocus: false
    implicitWidth: 390
    implicitHeight: 340
    Rectangle {

        id: rectId
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
    onIsFocusChanged: {
        root.focus = isFocus
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
    onPressAndHold: {


    }
    onPressed: (mouse) => {
                root.state = "Pressed";

            }

    onReleased:{
        root.focus = true
        root.state = "Focus"

    }
    //onClicked: rectId.clicked()
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
    onFocusChanged: {

        if (root.focus == true ){
            console.log("Media focus")
            root.state = "Focus"
        }
        else{
            console.log("Media end focus")
            root.state = "Normal"
        }
    }

    Image {
        id: bgBlur
        anchors.centerIn: rectId
        height:320
        width:387
        source: {
            if (PlaylistModel.rowCount() > 0 && PlaylistModel.rowCount() >  Playlist.currentIndex)
                return PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 259)
            else
                return "qrc:/App/ASM4/Image/album_art.png"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        anchors.centerIn: rectId
        width: rectId.width +26
        height: rectId.height+10
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        text: "USB Music"
        color: "white"
        font.pixelSize: 24
    }
    Image {
        id: bgInner
        anchors.centerIn: rectId
        width: 150
        height: 150
        source: {
            if (PlaylistModel.rowCount() > 0 && PlaylistModel.rowCount() >  Playlist.currentIndex)
                return PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 259)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        anchors.centerIn: rectId
        width: 150
        height: 150
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 250
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (PlaylistModel.rowCount() > 0 && PlaylistModel.rowCount() >  Playlist.currentIndex)
                return PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 258)
        }
        color: "white"
        font.pixelSize: 24
    }
    Text {
        id: txtTitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 280
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (PlaylistModel.rowCount() > 0 && PlaylistModel.rowCount() >  Playlist.currentIndex)
                return PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 26
    }
    Image{
        id: imgDuration
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }

    Image{
        id: imgPosition
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.left:imgDuration.left
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }





    Connections{
        target: Playlist
        onCurrentIndexChanged:{
            if (PlaylistModel.rowCount() > 0 && PlaylistModel.rowCount() > Playlist.currentIndex) {
                bgBlur.source = PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 259)
                bgInner.source = PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 259)
                txtSinger.text = PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 258)
                txtTitle.text = PlaylistModel.data(PlaylistModel.index(Playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 340
            imgDuration.height = 4
        }
        onPositionChanged: {
            imgPosition.width = (player.c_position / player.duration)*imgDuration.width;
            imgPosition.height = 4
        }
    }
}
