import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 1024
    minimumHeight: 200;
    minimumWidth: 200;
    title: "Main Window"
    color: "transparent"

    Rectangle {
        id: container
        anchors.fill: parent
        color: "lightgray"
    }
}
