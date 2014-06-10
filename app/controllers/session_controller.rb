class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    case params[:form_type]
    when "login"
      if @user = User.authenticate(params[:user][:email], params[:user][:password])
        log_user_in(@user)
        redirect_to root_url, notice: "Welcome!"
      else
        @user = User.new( user_params )
        render :new
      end
    when "signup"
      @registrant = Registrant.new( user_params )

      if @registrant.save
        EmailValidator.complete_registration(@registrant).deliver

        render text: "We sent you an email", status: :created
      else
        puts "Registrant save failed!"
        @user = User.new( user_params )
        flash.now[:alert] = "No workee!"
        render :new
      end
    else
      render text: "Resetting the password!"
      # Find user with params[:user][:email] email address
      # if not found, send "not found!" message
      # if found, send password reset email
    end
  end

  def destroy
    log_user_out
    redirect_to login_url
  end

  protected

  def user_params
    params.require(:user).permit( :email )
  end
end
