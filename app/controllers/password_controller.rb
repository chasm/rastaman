class PasswordController < ApplicationController
  before_action :redirect_if_logged_in, :get_user

  RESET_CODE_EXPIRED = %{
    Sorry, your password reset code expired. Please try again.
  }.squish

  def edit
  end

  def update
    result = PasswordReset.new
      .reset_user_password(@user, user_params)

    if result[:type] == :success
      flash[result[:type]] = result[:message]
      log_user_in(@user)
    else
      flash.now[result[:type]] = result[:message]
      render :new
    end
  end

  protected

  def get_user
    unless @user = User.find_by_code( params[:password_reset_code] )
      flash[:error] = RESET_CODE_EXPIRED
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
