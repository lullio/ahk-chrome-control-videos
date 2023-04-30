// capturar o video
{
let video = document.getElementsByTagName('video')[0];

// voltar 3 segundos de video
function rewind(value = 3) {
  video.currentTime -= value;
}
rewind(); // executar função
}
