class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]
  before_action :require_group_owner, only: %i[edit update destroy]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params.merge(owner: current_user))
    @group.group_users.new(user: current_user)

    if @group.save
      redirect_to group_path(@group), notice: "You have created group successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "You have updated group successfully."
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def require_group_owner
    redirect_to groups_path unless @group.owner?(current_user)
  end
end
