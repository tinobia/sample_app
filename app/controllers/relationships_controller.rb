class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])

    if @user
      current_user.follow(user)
      process
    else
      not_found_user
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if @user
      current_user.unfollow(user)
      process
    else
      not_found_user
    end
  end

  def process
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def not_found_user
    flash[:danger] = t "controllers.users.not_found_message"
    redirect_to root_url
  end
end
