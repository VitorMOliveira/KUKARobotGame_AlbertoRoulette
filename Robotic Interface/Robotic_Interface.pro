QT += quick multimedia network concurrent

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        backend.cpp \
        kukagamecontrol.cpp \
        kukavarproxy_msg_format.cpp \
        main.cpp \
        opencvimageprovider.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

#INCLUDEPATH += "C:\Programs\opencv\build\include"

#CONFIG(debug, debug|release){
#    message("Linking opencv debug libs")
#    LIBS += -LC:\Programs\opencv\build\x64\vc15\lib -lopencv_world454d
#} else {
#    message("Linking opencv release libs")
#    LIBS += -LC:\Programs\opencv\build\x64\vc15\lib -lopencv_world454
#}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    backend.h \
    kukagamecontrol.h \
    kukavarproxy_msg_format.h \
    opencvimageprovider.h

DISTFILES +=
