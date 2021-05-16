document.addEventListener('turbolinks:load', function() {

  function toggleSection(section, button) {
    if (section.classList.contains('d-none')) {
      section.classList.remove('d-none')
      button.innerText = '⬆ More information'
      } else {
        section.classList.add('d-none')
      button.innerText = '⬇ More information'
      }
  }

  // Hide/Show review form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-personal-link')) {
    const buttonPersonal = event.target
    const sectionPersonalForm = document.querySelector('.personal-info')
    event.preventDefault();
    toggleSection(sectionPersonalForm, buttonPersonal)
    }
  })
  // Hide/Show New Recipe form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-more-recipe-info')) {
    const buttonNewRecipe = event.target
    const sectionRecipeNewForm = document.querySelector('.more-recipe-info')
    event.preventDefault();
    toggleSection(sectionRecipeNewForm, buttonNewRecipe)
    }
  })
})


