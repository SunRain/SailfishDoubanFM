import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../js/Utils.js" as Utils

Page {
    id: player
    objectName: "playerPage"
    

    Drawer {
        id: drawer
        
        anchors.fill: parent
        dock: Dock.Top
        background: Channels {
            id: channels
            onChannelItemClicked: {
                cid = channelCid;
                name = channelName;
                drawer.open = false;
            }
        }

        SilicaFlickable {
            id: flickable
            anchors.fill: parent
            
            PullDownMenu {
                MenuItem {
                    text: qsTr("Channels")
                    onClicked: {
                        if (!drawer.opened) {
                            drawer.open = true
                        }
                    }     
                }
                MenuItem {
                    text: qsTr("Login")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("LoginForm.qml"));
                    }     
                }
                MenuItem {
                    text: qsTr("About")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
                    }     
                }
            }
            
            contentHeight:  column.height
            
            MouseArea {
                enabled: drawer.open
                anchors.fill: column
                onClicked: drawer.open = false
            }
            
            Column {
                id:column
                width: parent.width
                spacing: Theme.paddingMedium
                
                PageHeader {
                    title: "DoubanFM"
                }
                
                Item {
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: Theme.paddingLarge
                        rightMargin: Theme.paddingLarge
                    }
                    height: flickable.height*3/5
                    
                    Image {
                        id: imageAlbum
                        anchors.centerIn: parent
                        
                        source: song.picSource
                        
                        Rectangle {
                            id: bgc
                            anchors.fill: parent
                            color: "black"
                            opacity: 0.3
                            visible: false
                        }
                        
                        Text {
                            id: pauseTip
                            anchors.centerIn: parent
                            
                            text: "II"
                            color: "darkorange"
                            font { pointSize: 50; bold: true }
                            
                            visible: false
                        }
                        
                        states:State {
                            name: "PAUSE"
                            PropertyChanges { target: bgc; visible: true }
                            PropertyChanges { target: pauseTip; visible: true }
                        }
                        
                        MouseArea {
                            id: pauseClick
                            anchors.fill: parent
                            onClicked: {
                                if (audio.playbackState == Audio.StoppedState)
                                    return
                                // Pause Play
                                if (parent.state == "") {
                                    parent.state = "PAUSE"
                                    audio.pause();
                                    //audio.isPlaying = false;
                                } else {
                                    parent.state = ""
                                    audio.play();
                                    //audio.isPlaying = true;
                                }
                            }
                        }
                        //                    Component.onCompleted: {
                        //                        imageAlbum.state = audio.isPlaying
                        //                                ? ""
                        //                                : "PAUSE"
                        //                    }
                    }
                }
                
                Label {
                    id: position
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor 
                    text:playPositionText
                }
                
                Label {
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Theme.fontSizeMedium
                    elide: Text.ElideMiddle
                    text: song.name + " - " + song.artist + "    " + song.publicTime
                }
                Item {
                    id: toolBar
                    width: parent.width
                    height: childrenRect.height
                    
                    Image {
                        id: rate
                        anchors {
                            right: ban.left
                            rightMargin: Theme.paddingLarge
                        }
                        
                        source: song.like 
                                ? "../graphics/like.png"
                                : "../graphics/unlike.png"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                song.like = !song.like
                                applicationWindow.rate(song.like)
                                //applicationWindow.rated(song.like)
                            }
                        }
                    }
                    Image {
                        id: ban
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../graphics/ban.png"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                applicationWindow.ban()
                                //applicationWindow.banned()
                            }
                        }
                    }
                    Image {
                        id: next
                        anchors {
                            left: ban.right
                            leftMargin: Theme.paddingLarge
                        }
                        source: "../graphics/next.png"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                applicationWindow.skip();
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

