@slide = (target) ->
  $target = $(target)
  $('html, body').stop().animate { 'scrollTop': $target.offset().top }, 700, 'swing'

  return
