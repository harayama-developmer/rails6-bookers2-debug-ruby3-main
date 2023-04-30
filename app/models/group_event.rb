class GroupEvent < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :title, :content, presence: true

  after_create_commit :notify_group_users

  private

  def notify_group_users
    users = group.users
    users.each do |user|
      NotificationMailer.with(user: user, group_event: self).group_event.deliver_later
    end
  end
end
