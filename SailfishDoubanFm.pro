# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = SailfishDoubanFm

CONFIG += sailfishapp

SOURCES += src/SailfishDoubanFm.cpp

OTHER_FILES += qml/SailfishDoubanFm.qml \
    qml/cover/CoverPage.qml \
    rpm/SailfishDoubanFm.changes.in \
    rpm/SailfishDoubanFm.spec \
    rpm/SailfishDoubanFm.yaml \
    translations/*.ts \
    SailfishDoubanFm.desktop \
    qml/js/jsonpath.js \
    qml/js/Utils.js \
    qml/graphics/ban.png \
    qml/graphics/douban.png \
    qml/graphics/icon.png \
    qml/graphics/like.png \
    qml/graphics/logout.png \
    qml/graphics/next.png \
    qml/graphics/unlike.png \
    qml/pages/Channels.qml \
    qml/pages/JSONListModel.qml \
    qml/pages/LoginForm.qml \
    qml/pages/Player.qml \
    qml/pages/Song.qml \
    qml/pages/User.qml \
    qml/pages/AboutPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/SailfishDoubanFm-de.ts \
                translations/SailfishDoubanFm-zh_CN.ts

