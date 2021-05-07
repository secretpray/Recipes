document.addEventListener('turbolinks:load', function() {

  // Hide/Show review form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-review-link')) {
    const buttonComment = event.target
    const descriptionSection = document.querySelector('.section-description')
    event.preventDefault();
    const sectionCommentForm = document.querySelector('.review-form')
    
    if (sectionCommentForm.classList.contains('d-none')) {
      descriptionSection.classList.add('hide')
      sectionCommentForm.classList.remove('d-none')
      buttonComment.innerText = 'Hide comment'
      } else {
      descriptionSection.classList.remove('hide')
      sectionCommentForm.classList.add('d-none')
      buttonComment.innerText = 'Add comment'
      }
    }
  })
}) 
