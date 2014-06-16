$ ->
  $('#password-toggle').on 'click', (e) ->
    e.preventDefault()

    if $(@).hasClass("btn-warning")
      $(@).removeClass("btn-warning")
      $(@).addClass("btn-success")
      $(@).html("Hide passwords")
      $('.toggled').attr('type', 'text')
    else
      $(@).removeClass("btn-success")
      $(@).addClass("btn-warning")
      $(@).html("Show passwords")
      $('.toggled').attr('type', 'password')
