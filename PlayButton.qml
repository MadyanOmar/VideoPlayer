import QtQuick 2.12

Item {
    width: 100
    height: 100

    property bool isPlaying: false

    Image{
        source: isPlaying ? "img/pause.jpg" : "img/play.jpg"
        width: parent.width * 0.5
        height: parent.height * 0.5
        anchors.centerIn: parent
    }

}
