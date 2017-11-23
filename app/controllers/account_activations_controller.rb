class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "controllers.account_activations_controller.activated"
    else
      flash[:danger] = t "controllers.account_activations_controller.failed_to_activate"
    end
    redirect_to root_url
  end
end
