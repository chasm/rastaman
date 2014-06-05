$ ->
  $('.form-selector').on 'click', 'li', (e) ->
    e.preventDefault()

    $('ul.form-selector li').each (idx) ->
      $(@).removeClass('active')

    $(@).addClass('active')

    switch $(@).attr('id')
      when 'sign-up-tab'
        $('#password-field').hide()
        $('#login-submit').val("Sign up")
        $('#login legend').html("Please sign up")
        $('[name=form-type]').val("signup")
      when 'reset-tab'
        $('#password-field').hide()
        $('#login-submit').val("Send password reset")
        $('#login legend').html("Enter your email to reset your password")
        $('[name=form-type]').val("reset")
      else
        $('#password-field').show()
        $('#login-submit').val("Sign in")
        $('#login legend').html("Please sign in")
        $('[name=form-type]').val("login")
