class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    login_remember user
  end

  def login_remember user
    if user && user.authenticate(params[:session][:password])
      check_activated user
    else
      flash.now[:danger] = t "controllers.sessions_controller.danger"
      render :new
    end
  end

  def check_activated user
    if user.activated?
      log_in user
      params[:session][:remember_me] == Settings.session.remem.to_s ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "controllers.sessions_controller.unactivated"
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
