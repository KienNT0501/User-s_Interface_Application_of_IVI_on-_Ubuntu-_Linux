QT += quick core xml multimedia dbus

CONFIG += c++11
#DBUS_INTERFACES += Dbus/climate.xml
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
#DEFINES += QT_DEPRECATED_WARNINGs
DEFINES += PROJECT_PATH=\"\\\"$${_PRO_FILE_PWD_}/\\\"\"
SOURCES += \
        App/ASM4/player.cpp \
        App/ASM4/playlistmodel.cpp \
        App/ASM4/translator.cpp \
        App/Climate/climatemodel.cpp \
        applicationmodel.cpp \
        main.cpp \
        xmlreader.cpp \
        xmlwriter.cpp

RESOURCES += \
    Image.qrc \
    qml.qrc \
    xml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
LIBS += -ltag
HEADERS += \
    App/ASM4/player.h \
    App/ASM4/playlistmodel.h \
    App/ASM4/translator.h \
    App/Climate/climatemodel.h \
    applicationmodel.h \
    xmlreader.h \
    xmlwriter.h
TRANSLATIONS += translate_vn.ts\
                translate_us.ts

DISTFILES += \
    Dbus/climate.xml \
    applications.xml
