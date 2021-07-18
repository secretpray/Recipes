document.addEventListener('turbolinks:load', function() {

  function darkMode() {
    const wasDarkMode = localStorage.getItem('darkmode') == 'true'

    localStorage.setItem('darkmode', !wasDarkMode)
    document.body.classList.toggle('darkmode', !wasDarkMode)
  }

  const navheader = document.querySelector('.navbar-header')
  const navfooter = document.querySelector('.navbar-footer')

  document.body.classList.toggle('darkmode', localStorage.getItem('darkmode') == 'true')
  document.querySelector('.theme-switcher').addEventListener('click', darkMode)

  if (document.body.classList == 'darkmode' && navheader) {
    navheader.classList.remove('navbar-light', 'bg-light')
    navheader.classList.add('navbar-light', 'bg-warning')
  } else {
    navheader.classList.add('navbar-light', 'bg-light')
    navheader.classList.remove('navbar-light', 'bg-warning')
  }

  if (document.body.classList == 'darkmode' && navfooter) {
    navfooter.classList.remove('navbar-light', 'bg-light')
    navfooter.classList.add('navbar-light', 'bg-warning')
  } else {
    navfooter.classList.add('navbar-light', 'bg-light')
    navfooter.classList.remove('navbar-light', 'bg-warning')
  }
})
