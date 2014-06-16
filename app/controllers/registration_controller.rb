class RegistrationController < ApplicationController
  before_action :redirect_if_logged_in, :get_registrant

  REGISTRATION_CODE_EXPIRED = %{
     Sorry, your registration code expired. Please try again.
   }.squish

  def new
  end

  def create
    result = UserRegistration.new
      .complete_user_registration(@registrant, user_params)

    if result[:user].valid?
      flash[result[:type]] = result[:message]
      log_user_in(result[:user])
    else
      @user = result[:user]
      flash.now[result[:type]] = result[:message]
      render :new
    end
  end

  protected

  def get_registrant
    if @registrant = Registrant.find_by_code( params[:sign_up_code] )
      @user = User.new(email: @registrant.email)
    else
      flash[:error] = REGISTRATION_CODE_EXPIRED
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
