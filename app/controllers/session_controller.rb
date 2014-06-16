class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]

    result = case params[:form_type]
      when "login"
        UserLogin.new.log_user_in(email, password)
      when "signup"
        UserRegistration.new.send_registration_email(email)
      else
        PasswordReset.new.send_reset_email(email)
      end

    if result[:user].nil?
      @user = User.new( user_params )
      flash.now[result[:type]] = result[:message]
      render :new
    else
      log_user_in( result[:user] )
    end
  end

  def destroy
    log_user_out
  end

  protected

  def user_params
    params.require(:user).permit( :email )
  end
end
