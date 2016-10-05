$(document).ready(function() {
  $('#image-gallery').lightSlider({
    item: 1,
    auto: true,
    gallery: true,
    loop: true,
    pause: 5000,
    keyPress: true,
    onSliderLoad: function() {
      $('#image-gallery').removeClass('cS-hidden');
    }
  });
});
