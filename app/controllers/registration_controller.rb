class RegistrationController < ApplicationController

  def new
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new(email: @registrant.email)
    else
      render text: "You're registration is expired!"
    end
  end

  def create
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new( user_params.merge(email: @registrant.email) )

      if @user.save
        @registrant.destroy

        log_user_in(@user)

        redirect_to root_url
      else
        render :new
      end
    else
      render text: "You're registration is expired!"
    end
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
