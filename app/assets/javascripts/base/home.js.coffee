jQuery ->
  $('a[data-toggle="slide"]').on 'click', (e) ->
    e.preventDefault()
    target = @hash
    $target = $(target)
    $('html, body').stop().animate { 'scrollTop': $target.offset().top }, 700, 'swing'
    
    return
