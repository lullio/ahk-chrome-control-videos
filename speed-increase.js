// capturar o video
{
let video = document.getElementsByTagName('video')[0];

// aumentar velocidade do video
function speed(value = 0.25) {
  video.playbackRate += value;
}
if(video.playbackRate <=4.0){ // para não dar erro, executar somente se a velocidade for menor ou igual a 4
  speed(); // executar função
}
}
