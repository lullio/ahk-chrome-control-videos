// capturar o video
{
var video = document.querySelectorAll('video')[0];
/*
FIX TOP QUE ARRUMEI PARA NÃO RESETAR O playbackRate ao dar play no video
*/
if(video){
	video.onplay = (e) => {
		e.target.playbackRate = localStorage.getItem('videoSpeed');
		console.log("playbackRate ajustado para: ", e.target.playbackRate)
	}
}
	
// TOGGLE PAUSAR / PLAY
if(video?.paused){ // se tiver pausado, paused é um método js
	video.play();
	console.log("play no video");
}else{
	// video.playbackRate = localStorage.getItem('videoSpeed');
	video?.pause();
	// video.defaultPlaybackRate = localStorage.getItem('videoSpeed');
	console.log("pause no video");
}

}


