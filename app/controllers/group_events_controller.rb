class GroupEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :require_group_owner

  def show
    @group_event = @group.group_events.find(params[:id])
  end

  def new
    @group_event = GroupEvent.new
  end

  def create
    @group_event = @group.group_events.new(group_event_params)
    @group_event.user = current_user

    if @group_event.save
      redirect_to group_group_event_path(@group, @group_event)
    else
      render :new
    end
  end

  private

  def group_event_params
    params.require(:group_event).permit(:title, :content)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def require_group_owner
    redirect_to groups_path unless @group.owner?(current_user)
  end
end
