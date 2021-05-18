document.addEventListener('turbolinks:load', function() {

  // Hide/Show review form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-advanced-search-form')) {
    const buttonSearch = event.target
    const sectionSearchForm = document.querySelector('.section-advanced-search')
    const sectionSimpleSearchForm = document.querySelector('.simple-search')
    event.preventDefault();
    if (sectionSearchForm.classList.contains('d-none')) {
      sectionSearchForm.classList.remove('d-none')
      sectionSimpleSearchForm.classList.add('d-none')
      buttonSearch.innerText = '▲'
      } else {
      sectionSearchForm.classList.add('d-none')
      sectionSimpleSearchForm.classList.remove('d-none')
      buttonSearch.innerText = '▼'
      }
    }
  })
}) 
