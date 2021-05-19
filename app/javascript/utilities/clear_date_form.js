document.addEventListener('turbolinks:load', function() {

  const controllerName = document.body.dataset.controllerName
  const actionName = document.body.dataset.actionName
  
  if (controllerName == 'recipes' && actionName == 'index') {
    const dataGteg = document.getElementById('q_created_at_gteq')
    const dataLteg = document.getElementById('q_created_at_lteq')
    const timeSpanss = document.querySelector('.clear-date-input')
  
    dataGteg.addEventListener("input", function (event) {
      if (dataGteg && dataGteg.value != '') {
        dataGteg.nextElementSibling.classList.remove('d-none')
      }
    })

    dataLteg.addEventListener("input", function (event) {
      if (dataLteg && dataLteg.value != '') {
        dataLteg.nextElementSibling.classList.remove('d-none')
      }
    })
  }

  // Clear date input form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('clear-date-input')) {
      event.target.parentElement.parentElement.children[1].value = ''
      // event.target.parentNode.nextElementSibling.value = ''
      event.preventDefault();
      }
  })
}) 