{
		// clicar no legenda
	document.querySelectorAll('[aria-label="Legendas"]')[0].parentElement.parentElement.click();
	console.log("click legend icon")
	var optionDesligado;
    var optionIngles;
			// selecionar desligado ou ingles
	var selectionsAtive = document.querySelectorAll('[aria-checked="true"]');
    var allOptions = document.querySelectorAll('ul[aria-label="Legendas"] li');
    allOptions.forEach(val => {
        if(val.textContent.includes('Ingl')){
            optionIngles = val;
        }else if(val.textContent.includes('Deslig')){
            optionDesligado = val;
        }
    })
    if(optionDesligado.firstChild.getAttribute('aria-checked') == 'true'){
        optionIngles.firstChild.firstChild.click();
    }else{
        optionDesligado.firstChild.firstChild.click();
    }



	// document.querySelectorAll('[aria-label="Legendas"]')[0].parentElement.parentElement.click();
	// console.log("click legend icon")
	
	// 		// selecionar desligado ou ingles
	// let selectionsAtive = document.querySelectorAll('[aria-checked="true"]');
	// selectionsAtive.forEach(val => {
	// 	if(val.textContent.includes("Desligado")){
	// 		// selecionar ingles
	// 		document.querySelectorAll('[aria-checked="true"')[1].closest('li').nextElementSibling.nextElementSibling.firstChild.click();
	// 		console.log("legenda: ingles selecionado")
	// 	}else if(val.textContent.includes("Ingl")){
	// 		// selecionar desligado
	// 			document.querySelectorAll('[aria-checked="true"')[1].closest('li').previousSibling.previousSibling.firstChild.firstChild.click();
	// 			console.log("legenda: desabilitado selecionado")
	// 	}
	// })
}