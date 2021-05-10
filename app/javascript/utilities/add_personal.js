document.addEventListener('turbolinks:load', function() {

  // Hide/Show review form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-personal-link')) {
    const buttonPersonal = event.target
    const sectionPersonalForm = document.querySelector('.personal-info')
    event.preventDefault();
    
    if (sectionPersonalForm.classList.contains('d-none')) {
      sectionPersonalForm.classList.remove('d-none')
      buttonPersonal.innerText = '⬆ Personal information'
      } else {
        sectionPersonalForm.classList.add('d-none')
      buttonPersonal.innerText = '⬇ Personal information'
      }
    }
  })
}) 
