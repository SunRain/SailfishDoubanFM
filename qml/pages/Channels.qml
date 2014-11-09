import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/Utils.js" as Utils

Item {
    id: channel
    objectName: "ChannelList"
    anchors.fill: parent
    
    signal channelItemClicked(string channelCid, string channelName);
    
    ListModel {
        id: channelModel
        
        ListElement { cid: 0; name: "我的私人"; type: "私人电台" }
        ListElement { cid: -3; name: "我的红星"; type: "私人电台" }
        
        ListElement { cid: 1; name: "华语"; type: "公共电台" }
        ListElement { cid: 6; name: "粤语"; type: "公共电台" }
        ListElement { cid: 2; name: "欧美"; type: "公共电台" }
        ListElement { cid: 22; name: "法语"; type: "公共电台" }
        ListElement { cid: 17; name: "日语"; type: "公共电台" }
        ListElement { cid: 18; name: "韩语"; type: "公共电台" }
        ListElement { cid: 3; name: "70"; type: "公共电台" }
        ListElement { cid: 4; name: "80"; type: "公共电台" }
        ListElement { cid: 5; name: "90"; type: "公共电台" }
        ListElement { cid: 7; name: "摇滚"; type: "公共电台" }
        ListElement { cid: 8; name: "民谣"; type: "公共电台" }
        ListElement { cid: 9; name: "轻音乐"; type: "公共电台" }
        ListElement { cid: 10; name: "电影原声"; type: "公共电台" }
        ListElement { cid: 13; name: "爵士"; type: "公共电台" }
        ListElement { cid: 14; name: "电子"; type: "公共电台" }
        ListElement { cid: 15; name: "说唱"; type: "公共电台" }
        ListElement { cid: 16; name: "R&B"; type: "公共电台" }
        ListElement { cid: 20; name: "女生"; type: "公共电台" }
    }
    
    SilicaListView {
        id: channelList
        anchors.fill: parent
        model: channelModel
        header: PageHeader { title: qsTr("Channels") }
        section {
            property: 'type'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: BackgroundItem {
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingLarge
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                text: model.name + " MHz"
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                
            }
            onClicked: {
                channelList.currentIndex = index;
                var cid = channelModel.get(channelList.currentIndex).cid;
                var name = channelModel.get(channelList.currentIndex).name;
                console.log("======= cid is " + cid + " name is " + name);
                //newChannel();
                channelItemClicked(cid, name);
            }
        }
        VerticalScrollDecorator {}
        
        Component.onCompleted: {
            currentIndex = 2;
        }
    }
}

