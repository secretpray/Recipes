document.addEventListener('turbolinks:load', function() {
	// Позволяем запуск скрипта только в recipes#show
	var controllerPart = {};
	controllerPart = document.querySelector('body').dataset.controllerName
	var actionPart = {};
	actionPart = document.querySelector('body').dataset.actionName;
	
	if (controllerPart == 'recipes' && actionPart == 'show') {
		// Получаем ссылкb на дочерние DOM элементыЖ class = "ratings" 
		const stars = document.querySelector(".ratings").children;
		const ratingValue = document.getElementById("rating-value");
		const ratingValueDisplay = document.getElementById("rating-value-display");
		let index;

		for(let i=0; i<stars.length; i++){
			// console.log(stars.length)
			// Функция, которая будет выполняться при наведении курсора на звезду
			stars[i].addEventListener("mouseover",function(){
				// Когда курсор наведен на звезды, он повторяется 5 раз
				for(let j=0; j<stars.length; j++){
					// console.log(stars.length)
					// Сначала очистим все звезды
					stars[j].classList.remove("fa-star");
					stars[j].classList.add("fa-star-o");
				}
				// После этого следующая функция повторяется по количеству звезд.
				for(let j=0; j<=i; j++){
					// console.log(stars.length)
					stars[j].classList.remove("fa-star-o");
					// Заливаем звезды до звезды, на которой стоит курсор
					stars[j].classList.add("fa-star");
				}
			})
			// Подставляем звездочку + 1 в значение ratingValue
			stars[i].addEventListener("click",function(){
				ratingValue.value = i+1;
				ratingValueDisplay.textContent = ratingValue.value;
				// Подставляем номер звезды, на которую кликнули, вместо индекса
				index = i;
			})
			// Функция выполняется, когда курсор покидает звездочку
			stars[i].addEventListener("mouseout",function(){
				// Сначала повторяем 5 раз
				for(let j=0; j<stars.length; j++){
					// Сначала вычищваем все звезды
					stars[j].classList.remove("fa-star");
					stars[j].classList.add("fa-star-o");
				}
				for(let j=0; j<=index; j++){
					// Заполняем до нажатой звезды
					stars[j].classList.remove("fa-star-o");
					stars[j].classList.add("fa-star");
				}
			})
		}
	}
})