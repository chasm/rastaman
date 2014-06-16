$ ->
  checkStrength = ->
    if zxcvbn?
      pw = $('#user_password').val()
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

      if score > 2
        $('#update-button').attr('disabled', false)
      else
        $('#update-button').attr('disabled', true)

  checkMatch = ->
    pw = $('#user_password').val()
    pwc = $('#user_password_confirmation').val()

    console.log "#{pw} == #{pwc}"
    if pw == pwc
      $('#match-div').html("Passwords match!").addClass('pw-match')
      $('#match-div').html("Passwords don't match!").removeClass('pw-match')

  $('.strength-check').on 'keyup', (e) ->
    checkStrength()

  $('.match-check').on 'keyup', (e) ->
    checkMatch()
