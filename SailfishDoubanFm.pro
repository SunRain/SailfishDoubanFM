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
TARGET = harbour-sailfishdoubanfm

CONFIG += sailfishapp

SOURCES += src/SailfishDoubanFm.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    translations/*.ts \
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
    qml/pages/AboutPage.qml \
    qml/harbour-sailfishdoubanfm.qml \
    rpm/harbour-sailfishdoubanfm.spec \
    rpm/harbour-sailfishdoubanfm.changes.in \
    rpm/harbour-sailfishdoubanfm.yaml \
    harbour-sailfishdoubanfm.desktop \
    rpm/harbour-sailfishdoubanfm.yaml \
    rpm/harbour-sailfishdoubanfm.spec \
    rpm/harbour-sailfishdoubanfm.changes.in \
    qml/harbour-sailfishdoubanfm.qml \
    translations/harbour-sailfishdoubanfm.ts \
    translations/harbour-sailfishdoubanfm-zh_CN.ts

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-sailfishdoubanfm-de.ts \
                translations/harbour-sailfishdoubanfm-zh_CN.ts

