document.addEventListener("turbolinks:load", function() {
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
    document.getElementById('myCanvasContainer').style.display = 'none';
  }
});
