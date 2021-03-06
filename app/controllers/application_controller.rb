class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def is_authenticated?
    redirect_to login_url unless current_user
  end

  def redirect_if_logged_in
    if current_user
      flash[:success] = "You are already logged in."
      redirect_to root_url
    end
  end

  protected

  def log_user_in(user)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def log_user_out
    session[:user_id] = nil
    redirect_to login_url
  end
end
