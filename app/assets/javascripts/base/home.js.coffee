jQuery ->
  slide = (target) ->
    $target = $(target)
    $('html, body').stop().animate { 'scrollTop': $target.offset().top }, 700, 'swing'

    return

  $('a[data-toggle="slide"]').on 'click', (e) ->
    e.preventDefault()
    slide(@hash)

  $('#cidade').change ->
    target = '#section-two'
    slide(target)
