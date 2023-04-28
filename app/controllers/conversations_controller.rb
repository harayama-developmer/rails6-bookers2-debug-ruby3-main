class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @conversation = current_user.conversations.find(params[:id])
    @user = @conversation.users.where.not(id: current_user).first

    ensure_mutual_follow!
  end

  def create
    @user = User.find(params[:user_id])

    ensure_mutual_follow!

    @conversation = current_user.conversations.find_by(id: @user.conversations) || Conversation.new

    if @conversation.new_record?
      @conversation.save
      @conversation.users << @user
      @conversation.users << current_user
    end

    redirect_to conversation_path(@conversation)
  end

  private

  def ensure_mutual_follow!
    unless current_user.mutual_follow?(@user)
      redirect_to user_path(@user)
    end
  end
end
