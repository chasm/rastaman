$ ->
  MINIMUM_SCORE = 3

  checkMatch = ->
    pw = $('#user_password').val()
    pwc = $('#user_password_confirmation').val()
    
    if pw == pwc
      $('#match-div').html("Passwords match!").addClass('pw-good')
      true
    else
      $('#match-div').html("Passwords don't match!").removeClass('pw-good')
      false

  checkStrength = ->
    pw = $('#user_password').val()
    score = 0

    if zxcvbn?
      result = zxcvbn(pw)

      score = result.score
      strength = score * 25

      color = switch score
        when 1 then "danger"
        when 2 then "warning"
        when 3 then "success"
        else "info"

      $('#strength-meter')
        .removeClass('progress-bar-danger')
        .removeClass('progress-bar-warning')
        .removeClass('progress-bar-success')
        .removeClass('progress-bar-info')
        .addClass('progress-bar-' + color)
        .css('width', strength + '%')

      $('#crack-time-display').html result.crack_time_display

      if score < MINIMUM_SCORE
        $('#score-quality').html("Password too weak!").removeClass('pw-good')
      else
        $('#score-quality').html("Password good enough!").addClass('pw-good')

    if checkMatch() and score >= MINIMUM_SCORE
      $('#update-button').attr('disabled', false)
    else
      $('#update-button').attr('disabled', true)

  $('.strength-check').on 'keyup', (e) ->
    checkStrength()
