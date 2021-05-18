document.addEventListener('turbolinks:load', function() {

  // Clear date input form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('clear-date-input')) {
      event.target.parentNode.nextElementSibling.value = ''
      event.preventDefault();
      }
  })
}) 