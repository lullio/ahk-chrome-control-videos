// capturar o video
{
let video = document.getElementsByTagName('video')[0];

// avançar video, parametro com valor padrao de 3 segundos, caso nao passe um argumento na funcao
function speed(value = 0.25) {
  video.playbackRate += value;
}
speed(); // executar função
}
