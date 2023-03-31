import QtQuick 2.0
import QtQuick.Window 2.0
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 840
    height: 680
    visible: true
    title: qsTr("Video Player")

    FileDialog{
        id: fileDialog
        onAccepted: {
            videoPlayer.stop()
            videoPlayer.source = fileDialog.currentFile
        }
    }

    Rectangle{
        width: parent.width
        height: parent.height * 0.8
        color: "black"

        Video{
            id: videoPlayer
            width: parent.width
            height: parent.height
            anchors.fill: parent.fill
            fillMode: VideoOutput.PreserveAspectFit
            source: "TripleDemo.mp4"
        }

        RoundButton{
            id: playerButton
            anchors.top: parent.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            contentItem: Item{
                width: playerButton.width
                height: playerButton.height
                Image{
                    id: playerButtonImage
                    width: parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "play.png"
                }
            }

            onClicked: {
                if(videoPlayer.hasVideo){
                    if(videoPlayer.playbackState === MediaPlayer.PlayingState){
                        videoPlayer.pause()
                        playerButtonImage.source = "play.png"
                    }
                    else{
                        videoPlayer.play()
                        playerButtonImage.source = "pause.png"
                    }
                }
            }
        }

        Slider{
            id: slider
            width: parent.width * 0.8
            anchors.top: parent.bottom
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter

            from: 0
            value: videoPlayer.position
            to: videoPlayer.duration

            onValueChanged: {
                if(slider.pressed){
                    videoPlayer.position = value
                }
            }
        }
    }



    Timer{
        interval: 500
                running: true
                repeat: true
                onTriggered: {
                    if (!slider.pressed) {
                        slider.value = videoPlayer.position
                    }
                }
    }

    MenuBar {
            id: menuBar
            anchors.left: parent.left
            anchors.right: parent.right

            Menu {
                title: qsTr("&File")
                Action {
                    text: qsTr("&Open")
                    onTriggered: fileDialog.open()
                }
            }
    }


}
