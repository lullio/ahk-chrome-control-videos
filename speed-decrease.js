// capturar o video

var video = document.getElementsByTagName('video')[0];

// diminuir velocidade do video
function speed(value = 0.25) {
  video.playbackRate -= value;
  video.defaultPlaybackRate -= value;
}
if(video.playbackRate >= 0.25){ // para não dar erro , só executar se a velocidade do video for maior ou igual a 0.25
  speed(); // executar função
  console.log("diminui a velocidade: ", video.playbackRate);
  localStorage.setItem('videoSpeed', video.playbackRate);
}
