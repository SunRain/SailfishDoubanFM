import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/Utils.js" as Utils

Page {
    id: setting
   // property var  propertyUser
    property alias name: user.name

    states: [
        State {
            name: "LOGIN"
            PropertyChanges { target: logoutButton; visible: true }
//            PropertyChanges { target: toolbar; active: true }
            PropertyChanges { target: info; opacity: 1 }
            PropertyChanges { target: loginForm; opacity: 0 }
        },
        State {
            name: "LOGOUT"
            PropertyChanges { target: errMsg; text: " " }
            PropertyChanges { target: logoutButton; visible: false }
            PropertyChanges { target: captcha; text: "" }
            PropertyChanges { target: captchaImg; source: "" }
            PropertyChanges { target: info; opacity: 0 }
            PropertyChanges { target: loginForm; opacity: 1 }
        }
    ]
    state: "LOGOUT"
    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 500 }
    }

//    Connections {
//        target: player
//        onRated: (setting.logined && like) ? ++user.liked : --user.liked
//        onBanned: setting.logined ? ++user.banned : user.banned
//    }

    Component.onCompleted: {
        if (Utils.isLogin) {
            user.name = Utils.name
            user.isDJ = Utils.isDJ
            user.isPro = Utils.isPro;
            user.liked = Utils.liked ;
            user.banned = Utils.banned;
            user.played = Utils.played ;            
            setting.state = "LOGIN";
        } else {
            setting.state = "LOGOUT";
        }
    }

    Column {
        id: loginForm
        anchors.centerIn: parent
        spacing: Theme.paddingMedium

        Label {
            id: errMsg

            color: "red"
            text: " "
        }

        TextField {
            id: username
            width: setting.width - Theme.paddingLarge*4
            height:implicitHeight
            font.pixelSize: Theme.fontSizeMedium 
            
            label: qsTr("UserName")
            placeholderText: qsTr("UserName")
            focus: true
            horizontalAlignment: TextInput.AlignLeft
            EnterKey.onClicked: {
                parent.focus = true;
            }
        }

        TextField {
            id: password
            width: setting.width - Theme.paddingLarge*4
            height:implicitHeight
            font.pixelSize: Theme.fontSizeMedium 
            
            label: qsTr("PassWord")
            placeholderText: qsTr("PassWord")
            focus: true
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignLeft
            EnterKey.onClicked: {
                parent.focus = true;
            }
        }

        TextField {
            id: captcha
            width: setting.width - Theme.paddingLarge*4
            height:implicitHeight
            font.pixelSize: Theme.fontSizeMedium 
            
            label: qsTr("VerificationCode")
            placeholderText: qsTr("VerificationCode")
            focus: true
            horizontalAlignment: TextInput.AlignLeft
            //                KeyNavigation.tab: username
            //                KeyNavigation.backtab: password
            EnterKey.onClicked: {
                parent.focus = true;
            }
        }
        Row {
            spacing: Theme.paddingSmall
            anchors.horizontalCenter: parent.horizontalCenter
            
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                color: "lightgray"
                
                Label { 
                    //anchors.centerIn: parent
                    text: qsTr("click to show verification code") 
                }
                Image {
                    id: captchaImg
                    property string captchaId: ""
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Utils.getCaptcha(captchaImg);
                }
            }
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            
            text: qsTr("Login")
            onClicked: Utils.login(username.text,
                                   password.text,
                                   captcha.text,
                                   captchaImg.captchaId,
                                   statusModel)
        }
    }

    Grid {
        id: info
        anchors.centerIn: parent
        columns: 2
        spacing: Theme.paddingSmall

        opacity: 0

        Label { text: qsTr("Name:") }
        Label { text: user.name }

        Label { text: qsTr("DJ:") }
        Label { text: user.isDJ ? qsTr("Yes") : qsTr("No") }

        Label { text: qsTr("PRO:") }
        Label { text: user.isPro ? qsTr("Yes") : qsTr("No") }

        Label { text: qsTr("Played:") }
        Label { text: user.played /*+ qsTr("首")*/ }

        Label { text: qsTr("Rated:") }
        Label { text: user.liked /*+ qsTr("首") */}

        Label { text: qsTr("Banned:") }
        Label { text: user.banned/* + qsTr("首") */}

    }

//    ToolbarActions {
//        id: toolbar

//        Action {
//            id: logoutAct
//            iconSource: Qt.resolvedUrl("logout.png")
//            text: qsTr("退出")
//            onTriggered: {
//                // Logout
//                Utils.logout(userModel.model.get(0).ck)
//                setting.state = "LOGOUT"
//            }
//        }
//    }
    Button {
        id: logoutButton
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: info.bottom
            topMargin: Theme.paddingMedium
        }
        text: qsTr("Logout")
        onClicked: {
            Utils.logout(userModel.model.get(0).ck);
            setting.state = "LOGOUT";
            Utils.setLogind(false);
        }
    }

    User { id: user }

    JSONListModel {
        id: userModel
        query: "$.user_info"

        onJsonChanged: {
            if (count > 0) {
                // Login
                user.userInfo = userModel.model.get(0);
                //Utils.propertyUser = user;
                Utils.name = user.name;
                Utils.isDJ = user.isDJ;
                Utils.isPro = user.isPro;
                Utils.liked = user.liked;
                Utils.banned = user.banned;
                Utils.played = user.played;
                setting.state = "LOGIN";
                Utils.setLogind(true);
            }
        }
    }

    JSONListModel {
        id: statusModel
        query: "$"

        onJsonChanged: {
            if (count > 0) {
                var o = model.get(0);
                if (o.r === 0) {
                    userModel.json = json;
                } else {
                    errMsg.text = o.err_msg;
                    if (o.err_no === 1011) {    // captcha error
                        Utils.getCaptcha(captchaImg);
                    }
                }
            } else {
                Utils.log(json);
            }
        }
    }
}


