document.addEventListener('turbolinks:load', function() {

  function fadeOut(object) {
    if (object) {
      object.classList.add('fadeout');
      window.setTimeout(function() {
        object.innerText = '';
        object.remove();
      }, 7000);
    }
  }
  // Dismiss alert flash (button close)
  var flashModal = {};
  flashModal = document.querySelector('.alert')

  if (flashModal) {
    fadeOut(flashModal)

    flashModal.addEventListener("click", (event) => {
      flashModal.remove()
    });
  }

  // Dismiss dropdown search list (button close)
  var butttonAutoComplete = {}
  butttonAutoComplete = document.querySelector(".autocomplete-close")
  var dropList = {}
  dropList = document.querySelector("#results-dropdown")

  if (butttonAutoComplete) {
    butttonAutoComplete.addEventListener('click', () => {
      dropList.innerText = '';
    })
  }



  // Dismiss errors modal (button close)
  var errorModal = {};
  errorModal = document.querySelector('.errors-modal')

  if (errorModal) {
    fadeOut(errorModal)

    errorModal.addEventListener("click", (event) => {
      errorModal.remove();
    })
  }

  // Timeout autohide Devise error
  const deviseErrorExplanation = document.getElementById('error_explanation');
  if (deviseErrorExplanation) fadeOut(deviseErrorExplanation)


   // For inline errors only
  const commentObserver = document.querySelector(".errors-comment");

  const observer = new MutationObserver(function() {
    const inlineError = document.getElementById('errors-content')

    if (inlineError) {
      fadeOut(inlineError)

      inlineError.addEventListener("click", (event) => {
        inlineError.remove();
      })
    }
  });

  if (commentObserver) {
    observer.observe(commentObserver, {childList: true, subtree: true });
   }
})
