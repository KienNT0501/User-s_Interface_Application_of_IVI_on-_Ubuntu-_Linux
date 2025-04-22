import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

Item {
    id: root
    width: 1215
    height: 1145
    function openApplication(url){
        parent.push(url)
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_Up) {
            console.log("Key Up Pressed")
            focusArea = 0
            lvWidget.currentIndex = 0
            focusIndex = lvWidget.currentIndex
        } else if (event.key === Qt.Key_Down) {
            console.log("Key Down Pressed")
            focusArea = 1
            lvAppication.currentIndex = 0
            focusIndex = lvAppication.currentIndex
        }

        if (focusArea === 0) {
            if (event.key === Qt.Key_Right
                    && lvWidget.currentIndex >= 0
                    && lvWidget.currentIndex < lvWidget.count - 1) {
                console.log("Key Right Pressed")
                lvWidget.currentIndex = lvWidget.currentIndex + 1
                focusIndex = lvWidget.currentIndex
            } else if (event.key === Qt.Key_Left
                       && focusIndex > 0
                       && focusIndex <= lvWidget.count - 1) {
                console.log("Key Left Pressed")
                lvWidget.currentIndex = lvWidget.currentIndex - 1
                focusIndex = lvWidget.currentIndex
            }
        }
        else if (focusArea === 1) {
            if (event.key === Qt.Key_Right
                    && focusIndex >= 0
                    && focusIndex <lvAppication.count - 1) {
                console.log("Key Right Pressed")
                lvAppication.currentIndex =lvAppication.currentIndex + 1
                focusIndex =  lvAppication.currentIndex
            } else if (event.key === Qt.Key_Left
                       && focusIndex > 0
                       && focusIndex <= lvAppication.count - 1) {
                console.log("Key Left Pressed")
                 lvAppication.currentIndex =  lvAppication.currentIndex - 1
                focusIndex =  lvAppication.currentIndex
            }
        }
        if (event.key === Qt.Key_Return && focusArea) {
            openApplication(lvAppication.model.items.get(focusIndex).model.url)
            console.log("Key Enter Pressed")
        }
         else if (event.key === Qt.Key_Return && focusArea === 0)
            switch (focusIndex) {
            case 0: {openApplication("qrc:/App/Map/Map.qml") ; break}
            case 1: {openApplication("qrc:/App/Climate_qml/Climate.qml") ; break}
            case 2: {openApplication("qrc:/App/ASM4/main.qml") ; break}
            }

    }

property int focusArea: 1
property int focusIndex:0
    property bool isReorder: false
    //signal  mediaWidgetClicked(string url)
    ListView {
        id: lvWidget
        spacing: 15
        orientation: ListView.Horizontal
        width: 1230
        height: 340
        interactive: false
        focus: false
        anchors.left: parent.left
        anchors.leftMargin: 7
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModelWidget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }
            Keys.onPressed: {
               console.log("pressed!")
            }
            delegate:
                DropArea {
                id: delegateRootWidget
                focus: false
                width: 390; height: 340
                keys: ["widget"]
                z:0
                //property bool isFocused: false


                Loader {
                    id: iconWidget
                    property int visualIndex: 0
                    z:1
                    width: 390; height: 340
                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                }
            }
        }

        Component {
            id: mapWidget

            MapWidget{
               // anchors.fill:parent
                id: mapItem
                isFocus: (focusArea === 0 && focusIndex === 0)
                onClicked: { openApplication("qrc:/App/Map/Map.qml")
                }
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = 0
                    focusIndex = 0
                    console.log(focusIndex)
                }
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
                id:climateItem
                isFocus: (focusArea === 0 && focusIndex === 1)
                onClicked: {
                     openApplication("qrc:/App/Climate_qml/Climate.qml")
                }
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = 1
                    focusIndex = 1
                    console.log(focusIndex)
                }

            }
        }
        Component {
            id: mediaWidget

            MediaWidget {
                id: mediaItem
                isFocus: (focusArea === 0 && focusIndex === 2)
                onClicked: {
                    appHeaderId.isShowBackBtn = true;
                    slideOutAnimation.start();

                }
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = 2
                    focusIndex = 2
                    console.log(focusIndex)
                }
                // Define the animation inside MediaWidget
                SequentialAnimation {
                    id: slideOutAnimation

                    PropertyAnimation {
                        target: root
                        property: "x"
                        from: 0
                        to: -1920
                        duration: 500
                        easing.type: Easing.OutCubic
                    }
                    onFinished: {
                     openApplication("qrc:/App/ASM4/main.qml");
                    }
                }
            }
        }


    }

    ListView {
        id:lvAppication
        x: 0
        y:340
        width: 1230; height: 300
        orientation: ListView.Horizontal
        interactive: true
        spacing: 5
        ScrollBar.horizontal: ScrollBar {
            anchors.bottom: parent.top
            height: 10
            width: 100
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad;}
        }
        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
               width: 198; height: 360
              /* Rectangle{
                 anchors.fill:parent
                 color:"gray"
               }*/
                keys: "AppButton"
                onEntered: {
                  console.log("Enter! ")
                  console.log("drag.source.visual index: "+drag.source.visualIndex)
                  console.log("icon.visualindex: "+icon.visualIndex)
                  visualModel.items.move(drag.source.visualIndex, icon.visualIndex)

                  focusIndex = lvAppication.currentIndex
                  console.log("End Move! ")
                  //console.log("items Index: "+DelegateModel.itemsIndex)
                  console.log("drag.source.visual index: "+drag.source.visualIndex)
                  console.log("icon.visualindex: "+icon.visualIndex)
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }
                 onExited: {
                    // app.drag.target = null
                     focusArea = 1
                     focusIndex = lvAppication.currentIndex
                      console.log("exited, fcArea: "+focusArea+" exited, fcIndex: "+focusIndex)

                 }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 198; height: 360
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                      AppButton{
                          id: app
                          anchors.fill: parent
                          title: model.title
                          icon: model.iconPath

                          isFocus:(focusArea === 1 && focusIndex === parent.visualIndex)
                          drag.axis: Drag.XAxis
                          onClicked: {
                              openApplication(model.url)
                              console.log("open by clicked")
                              //focusIndex = lvAppication.currentIndex
                          }
                          onPressAndHold: {
                              console.log("press and hold")
                              drag.target = parent
                              isReorder = true
                          }

                          onPressed: {
                              focusArea = 1
                              lvAppication.currentIndex = parent.visualIndex
                              focusIndex = parent.visualIndex
                              console.log(focusIndex)
                          }

                          onReleased: {
                              drag.target = null
                              root.focus =true
                              //focusIndex = parent.visualIndex
                              //focusArea = 1
                              console.log("-------------> "+focusIndex)
                              if (isReorder){
                                  var itemCount = visualModel.items.count;

                                  for (var pos = 0; pos < itemCount; pos++) {
                                      var appsItem = visualModel.items.get(pos);

                                      if (!appsItem || !appsItem.model) {
                                          console.warn("Skipping invalid item at position:", pos);
                                          continue;
                                      }
                                      var model = appsItem.model;
                                      console.log("Processing item:", pos, "Title:", model.title);

                                      appsModel.addApplication(pos, model.title, model.url, model.iconPath);
                                  }
                                   saveXML.saveDataAppMenu()
                                  isReorder = false
                          }

                          }
                          onWheel: {
                              if (wheel.angleDelta.y > 0) scroll.increase()
                              else scroll.decrease()
                          }
                    }

                    onFocusChanged: app.focus = icon.focus

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"
                    Drag.hotSpot.x: width/2
                    Drag.hotSpot.y: height/2
                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }

        }
    }
}
