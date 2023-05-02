	// clicar no legenda
{
	document.querySelectorAll('[aria-label="Legendas"]')[0].parentElement.parentElement.click();
	console.log("click legend icon")
	
			// selecionar desligado ou ingles
	let selectionsAtive = document.querySelectorAll('[aria-checked="true"]');
	selectionsAtive.forEach(val => {
		if(val.textContent.includes("Desligado")){
			// selecionar ingles
			document.querySelectorAll('[aria-checked="true"')[1].closest('li').nextElementSibling.nextElementSibling.firstChild.click();
			console.log("legenda: ingles selecionado")
		}else if(val.textContent.includes("Ingl")){
			// selecionar desligado
				document.querySelectorAll('[aria-checked="true"')[1].closest('li').previousSibling.previousSibling.firstChild.firstChild.click();
				console.log("legenda: desabilitado selecionado")
		}
	})
}