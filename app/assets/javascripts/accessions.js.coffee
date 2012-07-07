$(document).ready ->
  $('#applications .card').hover(
    ( ->
        $(this).find('div.mask').stop(false, true).fadeOut(200)
        $(this).find('div.caption').stop(false, true).fadeIn(200)
    ),
    ->
      $(this).find('div.caption').stop(false, true).fadeOut(200)
      $(this).find('div.mask').stop(false, true).fadeIn(200)
  )
