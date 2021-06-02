import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "results", "form" ]

  connect() {
    // console.log("Connected!")
  }

  search() {
    var inputAutocomplete = document.querySelector("#autocomplete-input")
    inputAutocomplete.addEventListener('keyup', (event) => {
      if (event.target.value.length > 1) {
        // wait for the user to stop typing before submitting the form
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
          Rails.fire(this.formTarget, 'submit')
        }, 200)
      }
      // clear droplist if input set to blank 
      if (event.target.value.length == 0) {
        var dropList = document.querySelector("#results-dropdown")
        if (dropList.size != 0) { dropList.innerText = '' }
      }
    })
  }

  handleResults() {
    // debugger;
    const [data, status, xhr] = event.detail
    this.resultsTarget.innerHTML = xhr.response
  }
}
