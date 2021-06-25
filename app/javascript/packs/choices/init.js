import * as Choices from 'choices.js'

document.addEventListener("turbolinks:load", function() {
  let targetInput = document.querySelector('#choices-multiple-remove-button')

  if (targetInput) {
    new Choices('#choices-multiple-remove-button', {
      delimiter: ',',
      maxItemCount: 5,
      removeItemButton: true,
      noChoicesText: 'Не выбран',
      itemSelectText: 'Пожалуйста выберите',
      addItemText: (value) => {
        return `Нажмите Enter чтобы добавить <b>"${value}"</b>`;
      },
      maxItemText: (maxItemCount) => {
        return `Максимальное значение: ${maxItemCount}`;
      },
      valueComparer: (value1, value2) => {
        return value1 === value2;
      },
    });
  }
});
