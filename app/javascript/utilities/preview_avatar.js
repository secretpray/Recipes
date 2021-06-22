document.addEventListener("turbolinks:load", function(event) {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader()
      reader.onload = function (e) {
        document.getElementById(input.id + "_medium").setAttribute('src', e.target.result)
        document.getElementById(input.id + "_medium").parentElement.classList.remove('d-none')
      }
      document.querySelector('.original-avatar').classList.add('invisible')
      reader.readAsDataURL(input.files[0])
    }
  }

  var inputFile = document.querySelector(".photo_upload")
  if (inputFile) {
    inputFile.addEventListener('change', function() {
      readURL(this)
    })
  }
})
