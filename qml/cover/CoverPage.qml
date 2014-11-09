/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.
  
  You may use this file under the terms of BSD license as follows:
  
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
      
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR 
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

CoverBackground {
//    property Audio audio
    
//    Label {
//        id: label
//        anchors.centerIn: parent
//        text: qsTr("My Cover")
//    }
        Image {
            id: imageAlbum
            anchors.centerIn: parent
            
            source: song.picSource
            
//            Rectangle {
//                id: bgc
//                anchors.fill: parent
//                color: "black"
//                opacity: 0.3
//                visible: false
//            }
            
//            Text {
//                id: pauseTip
//                anchors.centerIn: parent
                
//                text: "II"
//                color: "darkorange"
//                font { pointSize: 50; bold: true }
                
//                visible: false
//            }
            
//            states:State {
//                name: "PAUSE"
//                PropertyChanges { target: bgc; visible: true }
//                PropertyChanges { target: pauseTip; visible: true }
//            }
            
//            MouseArea {
//                id: pauseClick
//                anchors.fill: parent
//                onClicked: {
//                    if (audio.playbackState == Audio.StoppedState)
//                        return
//                    // Pause Play
//                    if (parent.state == "") {
//                        parent.state = "PAUSE"
//                        audio.pause();
//                    }
//                    else {
//                        parent.state = ""
//                        audio.play()
//                    }
//                }
//            }
        }
    
    
//    CoverActionList {
//        id: coverAction
        
//        CoverAction {
//            iconSource: {
//                if (audio.playbackState == Audio.StoppedState)
//                    return "";
////                if (imageAlbum.state == "") {
////                    imageAlbum.state = "PAUSE"
////                    //audio.pause();
////                    return "image://theme/icon-cover-next";
////                } else {
////                    imageAlbum.state = "";
////                    //audio.play();
////                    return "image://theme/icon-cover-pause";
////                }
//////                return "image://theme/icon-cover-next"
//                if (audio.isPlaying) {
//                    imageAlbum.state == "";
//                    return "image://theme/icon-cover-pause";
//                } else {
//                    imageAlbum.state = "PAUSE";
//                    return "image://theme/icon-cover-next"
//                }
//            }
//            onTriggered: {
//                if (audio.playbackState == Audio.StoppedState)
//                    return
//                if (audio.isPlaying) {
//                    audio.pause();
//                } else {
//                    audio.play();
//                }
//            }
//        }
        
////        CoverAction {
////            iconSource: "image://theme/icon-cover-pause"
////        }
//    }
}


