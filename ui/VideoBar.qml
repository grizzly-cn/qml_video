import QtQuick 2.4

VideoBarForm {
    function setVolimeStatu(){
        if(volumeSlider.y > 0){
            volumeSlider.y = - volumeSlider.height
        }else{
            volumeSlider.y = volumeSlider.height
        }
    }

    volume.onClicked: {
        setVolimeStatu()
    }
}
