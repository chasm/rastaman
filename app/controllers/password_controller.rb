class PasswordController < ApplicationController
  before_action :redirect_if_logged_in, :get_user

  def edit
  end

  def update
    if @user.update_attributes( user_params )
      @user.clear_reset
      flash[:success] = "Your password has been reset."
      log_user_in(@user)
    else
      flash.now[:error] = "Unable to reset your password. Please try again."
      render :edit
    end
  end

  protected

  def get_user
    unless @user = User.find_by_code( params[:password_reset_code] )
      flash[:error] = "Sorry, your password reset code expired. Please try again."
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
