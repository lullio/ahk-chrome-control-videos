function waitForElm(selector) {
   return new Promise(resolve => {
       if (document.querySelector(selector)) {
           return resolve(document.querySelector(selector));
       }
 
       const observer = new MutationObserver(mutations => {
           if (document.querySelector(selector)) {
               resolve(document.querySelector(selector));
               observer.disconnect();
           }
       });
 
       observer.observe(document.body, {
           childList: true,
           subtree: true
       });
   });
 }

window.addEventListener('popstate', function (event) {
	alert('url mudou')
});

waitForElm('video').then((elm) => {
   console.log('Element is ready');
   var video = document.querySelectorAll('video')[0];
elm.onplay = (e) => {
   e.target.playbackRate = localStorage.getItem('videoSpeed');
   console.log("playbackRate ajustado para: ", e.target.playbackRate)
}
elm.onpause = (e) => {
   e.target.playbackRate = localStorage.getItem('videoSpeed');
   console.log("playbackRate ajustado para: ", e.target.playbackRate)
}
});

