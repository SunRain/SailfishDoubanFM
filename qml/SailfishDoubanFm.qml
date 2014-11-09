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

import "pages"

import "js/Utils.js" as Utils


ApplicationWindow
{
    id:applicationWindow
    
    initialPage: Component { /*FirstPage { }*/Player{} }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    
    property bool rapidLoad: true
    property bool logined: false
    property var cid
    property var name
    
    property string playPositionText: "0 : 00"
//    property var propertyUser

    onCidChanged: {
        console.log("===== channel cid changed" )
        /*player.*/newChannel();
    }
//    signal rated(bool like)
//    signal banned
    
    Song {
        id: song 
    }
    
    Audio {
        id: audio
        source: song.source
        autoLoad: true
        
//        property bool isPlaying: false
        
        onStatusChanged: {
            if (status == Audio.EndOfMedia) {
                /*player.*/endReport();
                nextSong();
            } else if (status == Audio.Loaded) {
                //Utils.log("loaded");
                play();
            } else if (status == Audio.Buffered) {
                //Utils.log("Buffered");
                timer.restart();
            }
            /*else if (status == Audio.Loading) {
                console.log("loading");
            }  else if (status == Audio.Stalled) {
                console.log("stalled");
            } else if (status == Audio.InvalidMedia) {
                console.log("InvalidMedia");
            } else if (status == Audio.UnknownStatus) {
                console.log("UnknownStatus");
            } else if (status == Audio.NoMedia) {
                console.log("NoMedia")
            }
            */
        }
    }
    
    Timer {
        id: timer
        interval: 250
        repeat: true
        triggeredOnStart: true
        
        onTriggered: {
            var time = new Date(audio.position)
            playPositionText = Qt.formatTime(time, "m : ss")
        }
    }
    JSONListModel {
        id: statusModel
        query: "$"
        
        onJsonChanged: {
            if (count > 0) {
                var o = model.get(0);
                if (o.r === 0) {
                    songModel.json = json;
                } else {
                    Utils.log(o.err);
                }
            } else {
                console.log(json);
            }
        }
    }
    
    JSONListModel {
        id: songModel
        query: "$.song[*]"
        clear: false
        
        onJsonChanged: {
            if (count > 0) {
                /*player.*/nextSong();
            } else {
                Utils.log("error, no song in list");
            }
        }
    }

//    User { id: user }
    
    function nextSong() {
        if (songModel.count == 0) {
            /*player.*/newSongs();  // song list is empty, request new song list.
            return false;
        }
        
        Utils.log("song list: " + songModel.count);
        
        if (!/*player.*/rapidLoad) {
            return false;
        }
        
        song.songInfo = songModel.model.get(0);
        songModel.model.remove(0);
        
        return true;
    }
    
    function request(type) {
        var url = "http://douban.fm/j/mine/playlist?" + parameter(type);
        Utils.log(url)
        if (type !== "e") {
            Utils.log("song list clear");
            songModel.model.clear();
        }
        statusModel.source = url;
    }
    
    function newChannel() {
        /*player.*/rapidLoad = true;
        request("n");
    }
    function endReport() {
        /*player.*/rapidLoad = true;
        request("e");
    }
    function skip() {
        /*player.*/rapidLoad = true;
        request("s")
    }
    function newSongs() {
        /*player.*/rapidLoad = true;
        request("p")
    }
    function ban() {
        
        /*player.*/rapidLoad = true;
        request("b");
        if (Utils.isLogin) {
             ++Utils.banned;
        }
    }
    function rate(like) {
        /*player.*/rapidLoad = false;
        
        if (like) {
            request("r");
        } else {
            request("u");
        }
        if (Utils.isLogin) {
            if (like) 
                ++Utils.liked;
            else 
                --Utils.liked;
        }
    }
    
    function parameter(type) {
        var r = Number(Math.round(Math.random() * 0xF000000000) + 0x1000000000).toString(16);
        var s = "";
        s += ("type=" + type);
        s += ("&channel=" + /*channel.*/cid);
        s += ("&sid=" + song.sid);
        s += ("&pt=" + Math.round(audio.position / 1000));
        s += ("&r=" + r);
        s += ("&pb=64&from=mainsite");
        
        return s;
    }
}


