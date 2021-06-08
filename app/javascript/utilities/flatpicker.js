document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: "H :i",
    enableTime: true,
    noCalendar: true,
    time_24hr: true,
    // altFormat: "F j, Y",
    // dateFormat: "d-m-Y",
  })
})
