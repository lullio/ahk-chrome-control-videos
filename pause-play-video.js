// capturar o video
{
let video = document.getElementsByTagName('video')[0];
	
// TOGGLE PAUSAR / PLAY
if(video.paused){ // se tiver pausado, paused é um método js
	video.play();
}else{
	video.pause();
}

}


