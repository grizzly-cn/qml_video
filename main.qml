import QtQuick 2.12
import QtQuick.Controls 1.4
import "ui"
import QtMultimedia 5.14
import Qt.labs.platform 1.1
import MediaPlayList 1.0
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("视频播放器")
    Material.theme: Material.Red
    Material.accent: Material.Purple
    Material.elevation: 6


    MediaPlayer{
        id:mediaPlayer

        onPlaying: {
            videoBar.slider.from = 0
            videoBar.slider.to = mediaPlayer.duration
            videoBar.slider.value = mediaPlayer.position
            console.log(mediaPlayer.duration);
        }

        onPositionChanged: {
            videoBar.slider.value =  mediaPlayer.position
        }
    }

    MediaPlayList{
        id:mediaplaylist
    }

    Rectangle {
        id: background
        color: "#65bd60"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#65bd60"
            }

            GradientStop {
                position: 0.25
                color: "#5ac1a8"
            }

            GradientStop {
                position: 0.5
                color: "#3ec6ed"
            }

            GradientStop {
                position: 0.75
                color: "#b7ddb7"
            }

            GradientStop {
                position: 1
                color: "#fef381"
            }
        }
        anchors.fill: parent

        VideoBar{
            id: videoBar
            x: 0
            y: 440
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            /* 当进度条改变时,改变播放位置 */

            /* 当打开列表时，先选择要播放的音乐 */
            list.onClicked: {
                /* 让dialog显示 */
                fileDialog.visible = true
            }

            /* 播放音乐 */
            play.onClicked: {
                if(mediaplaylist.playList.length === 0){
                    /* 让dialog显示 */
                    fileDialog.visible = true
                }else{
                    /* 如果是播放，则暂停，反之则播放 */
                    if(mediaPlayer.playbackState === MediaPlayer.PlayingState){
                        mediaPlayer.pause()
                        videoBar.imagePlay.source = "qrc:/res/image/播放.png"
                    }else{
                        videoPlay()
                    }
                }
            }

            /* 播放上一曲 */
            before.onClicked: {
                var index = mediaplaylist.currentIndex
                /* 检查是不是第一个文件，如果是，则播放最后一个 */
                if(index === 0 ){
                    mediaplaylist.currentIndex = mediaplaylist.playList.length - 1
                }else{
                    mediaplaylist.currentIndex = index - 1
                }
                videoPlay()
            }

            /* 播放下一曲 */
            next.onClicked: {
                var index = mediaplaylist.currentIndex
                /* 检查是不是第一个文件，如果是，则播放最后一个 */
                if(index === mediaplaylist.playList.length - 1 ){
                    mediaplaylist.currentIndex = 0
                }else{
                    mediaplaylist.currentIndex = index + 1
                }
                videoPlay()
            }

            /* 调整音量 */
            volumeSlider.onValueChanged: {
                mediaPlayer.volume = volumeSlider.value
            }

            /* 拖动进度条，改变播放位置 */
            slider.onMoved: {
                mediaPlayer.position = slider.value
            }
        }

        VideoOutput{
            id:videOutput
            anchors.top: parent.top
            anchors.bottom: videoBar.top
            anchors.left: parent.left
            anchors.right: parent.right
            source: mediaPlayer
        }

    }

    FileDialog {
        id: fileDialog
        title: "选择音乐"
        folder: StandardPaths.writableLocation(StandardPaths.MoviesLocation)
        modality:Qt.ApplicationModal
        fileMode:FileDialog.OpenFiles
        nameFilters: ["视频文件 (*.mp4 *.AVI *.WMV)", "所有文件 (*.*)"]
        onAccepted: {
            var files =[] ;
            //            取得的信息保存到playlist
            console.log("选择的文件是: " + fileDialog.files)
            //          不要问我为什么要用for,因为我也不清楚，如果不用for，直接用fileDialog.files，playList会直接是空
            for(var i = 0 ; i < fileDialog.files.length ; i++)
            {
                files[i] = fileDialog.files[i]
            }
            mediaplaylist.playList =files
        }
        onRejected: {
            console.log("没有选择任何文件！")
        }
    }



    function videoPlay(){

        if(mediaplaylist.playList.length === 0){
            console.log("警告：" + "没有添加资源！")
        }else{
            mediaPlayer.pause()
            mediaPlayer.source = mediaplaylist.getPlayList()[mediaplaylist.currentIndex]
            mediaPlayer.play()
            videoBar.imagePlay.source = "qrc:/res/image/停止.png"
        }
    }

    Component.onCompleted: videoBar.volumeSlider.value = mediaPlayer.volume
}

/*##^##
Designer {
    D{i:3;anchors_height:200;anchors_width:200}
}
##^##*/
