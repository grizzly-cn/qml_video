import QtQuick 2.4
import QtQuick.Controls 2.13

Item {
    id: root
    width: 600
    height: 40
    property alias volume: volume
    property alias volumeSlider: volumeSlider
    property alias imagePlay: imagePlay
    property alias before: before
    property alias play: play
    property alias next: next
    property alias slider: slider
    property alias list: list

    Row {
        id: row
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        spacing: 0
        anchors.fill: parent

        Image {
            id: imageBefore
            width: row.height
            height: row.height
            source: "qrc:/res/image/上一首.png"
            fillMode: Image.PreserveAspectFit

            MouseArea {
                id: before
                anchors.fill: parent
            }
        }

        Image {
            id: imagePlay
            width: row.height
            height: row.height
            source: "qrc:/res/image/播放.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                id: play
                anchors.fill: parent
            }
        }

        Image {
            id: imageNext
            width: row.height
            height: row.height
            source: "qrc:/res/image/下一首.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                id: next
                anchors.fill: parent
            }
        }

        Slider {
            id: slider
            width: (parent.width - (row.children.length - 1) * imagePlay.height)
            to: 0
            value: 0
        }

        Image {
            id: imageList
            width: parent.height
            height: row.height
            MouseArea {
                id: list
                anchors.fill: parent
            }
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/image/文件.png"
        }

        Image {
            id: imageVolume
            width: parent.height
            height: row.height

            Slider {
                id: volumeSlider
                x: parent.width * 0.25
                y: volumeSlider.height
                width: parent.height * 0.5
                height: parent.height * 3
                orientation: Qt.Vertical
                value: 0
            }

            MouseArea {
                id: volume
                anchors.fill: parent
            }
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/image/音符02.png"
        }
    }
}

/*##^##
Designer {
    D{i:13;anchors_x:2;anchors_y:7}
}
##^##*/
