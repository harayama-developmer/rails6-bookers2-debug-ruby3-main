class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group_user = @group.group_users.new(user: current_user)

    if @group_user.save
      redirect_to group_path(@group)
    else
      redirect_to group_path(@group), notice: @group_user.errors.full_messages.to_sentence
    end
  end

  def destroy
    @group_user = @group.group_users.find_by!(user: current_user)
    @group_user.destroy
    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
