document.addEventListener('turbolinks:load', function() {
 
  // Dismiss alert flash (button close)
  const flashList = document.querySelector('.alert')

  if (flashList) {
    flashList.addEventListener("click", (event) => {
      flashList.remove()
    });
  }

   // Timeout autohide flash notice
  const notice = document.getElementById('flash-notice');
  if (notice) fadeOut(notice)

  // Timeout autohide flash alert
  const alert = document.getElementById('flash-alert');
  if (alert) fadeOut(alert)

  // Timeout autohide Devise error
  const deviseErrorExplanation = document.getElementById('error_explanation');
  if (deviseErrorExplanation) fadeOut(deviseErrorExplanation)

  // Timeout for autohide errors message
  const errors = document.getElementById('errors-content')
  if (errors) fadeOut(errors)

  function fadeOut(object) {
    if (object) {
      object.classList.add('fadeout');
      window.setTimeout(function() {
        object.innerText = '';
        object.remove();
      }, 7000);
    }
  }
})