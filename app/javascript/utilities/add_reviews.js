document.addEventListener('turbolinks:load', function() {

  // Hide/Show review form
  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('add-review-link')) {
    const buttonReview = event.target
    const sectionCommentForm = document.querySelector('.review-form')
    const descriptionSection = document.querySelector('.section-description')
    event.preventDefault();

    if (sectionCommentForm.classList.contains('d-none')) {
      descriptionSection.classList.add('hide')
      sectionCommentForm.classList.remove('d-none')
      buttonReview.innerText = 'Hide review'
      } else {
      descriptionSection.classList.remove('hide')
      sectionCommentForm.classList.add('d-none')
      buttonReview.innerText = 'Add review'
      }
    }
  })

  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('print-page')) {
      event.preventDefault();
      event.stopPropagation();
      window.print();
      return false;
    }
  })

  document.body.addEventListener("click", function (event) {
    if (event.target.classList.contains('show_hide_form')) {
      const buttonAddComment = event.target;
      const sectionNewComment = buttonAddComment.nextElementSibling;
      if (sectionNewComment.classList.contains('d-none')) {
        sectionNewComment.classList.remove('d-none')
        buttonAddComment.classList.add('d-none')
        event.preventDefault();
      }
    }
  })

})
