document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    enableTime: true,
    enableSeconds: false,
    noCalendar: true,
    altInput: true,
    time_24hr: true,
    altFormat: 'H:i',  // altFormat: 'h:i:S K' # with second
    dateFormat:  'H:i' // 'H:i:S' # with second
  })
})
