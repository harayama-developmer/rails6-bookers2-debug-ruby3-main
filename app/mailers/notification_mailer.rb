class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.group_event.subject
  #

  before_action do
    @user = params[:user]
    @group_event = params[:group_event]
  end

  def group_event
    mail to: @user.email, subject: @group_event.title
  end
end
