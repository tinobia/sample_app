class PasswordResetsController < ApplicationController
  before_action :pick_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "controllers.password_resets_controller.alert"
      redirect_to root_url
    else
      flash.now[:danger] = "controllers.password_resets_controller.not_found_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".cant_be_empty")
      render :edit
    elsif @user.update_attributes user_params
      reset_success
    else
      render :edit
    end
  end

  def reset_success
    log_in @user
    @user.update_attribute :reset_digest, nil
    flash[:success] = t "controllers.password_resets_controller.reseted"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def pick_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "controllers.password_resets_controller.expired"
    redirect_to new_password_reset_url
  end
end
