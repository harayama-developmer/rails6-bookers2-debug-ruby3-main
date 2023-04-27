class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    if current_user.follow(@user)
      redirect_to request.referer
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.unfollow(@user)
      redirect_to request.referer
    else
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
