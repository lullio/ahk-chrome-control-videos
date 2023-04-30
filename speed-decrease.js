// capturar o video
{
let video = document.getElementsByTagName('video')[0];

// diminuir velocidade do video
function speed(value = 0.25) {
  video.playbackRate -= value;
}
if(video.playbackRate >= 0.25){ // para não dar erro , só executar se a velocidade do video for maior ou igual a 0.25
  speed(); // executar função
}
}
