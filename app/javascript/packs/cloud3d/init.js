document.addEventListener("turbolinks:load", function() {
  const controllerName = document.body.dataset.controllerName
  const actionName = document.body.dataset.actionName

  if (controllerName == 'dashboards' && actionName == 'index') {
    try {
      // TagCanvas.Start('myCanvas');
      TagCanvas.Start('myCanvas','tags',{
              textColour: 'rgb(10, 88, 202)',
              outlineColour: 'rgba(60, 85, 200, 0.26)',
              reverse: true,
              depth: 0.9,
              maxSpeed: 0.05
            });
    } catch(e) {
      // something went wrong, hide the canvas container
      var containerCanvas = document.getElementById('myCanvasContainer')
      if (containerCanvas) {
        containerCanvas.style.display = 'none';
      }
    }
  }
});
