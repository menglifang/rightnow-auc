$(document).ready ->
  $('#applications .application').hover(
    ( ->
        $(this).find('div.caption').stop(false, true).fadeIn(200)
    ),
    ->
      $(this).find('div.caption').stop(false, true).fadeOut(200)
  )
