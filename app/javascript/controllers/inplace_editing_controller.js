import { Controller } from "stimulus"
export default class extends Controller {

  static targets = ["editable"]

  doubleClick(event) {
    event.preventDefault()

    // let editor = document.createElement("input")
    let originalTitleDiv = document.querySelector('.title-editor')
    let editor = document.querySelector('.form-inline-title')
    // editor.insertAdjacentHTML('beforeend', "<%= j render 'recipes/inline/form_title', recipe: @recipe %>");
    // editor.value = event.target.innerText
    originalTitleDiv.classList.add('d-none')
    editor.classList.remove('d-none')

    // let style = window.getComputedStyle(event.target)
    // editor.style.cssText = style.cssText

    editor.addEventListener('keypress', function(event) {
     var key = event.which || event.keyCode;
     if (key === 13 // 13 is enter
       || key == 27) { // 27 is escape
       // this.editableTarget.innerText = editor.value
       // this.editableTarget.classList.remove("editable--hidden")
       // editor.remove()
       originalTitleDiv.classList.remove('d-none')
       editor.classList.add('d-none')
     }
   }.bind(this));

   // let selection = window.getSelection()
   // editor.setSelectionRange(selection.anchorOffset, selection.anchorOffset)
   //
   // this.editableTarget.insertAdjacentElement('afterend', editor)
   // this.editableTarget.classList.add("editable--hidden")
  }
}
