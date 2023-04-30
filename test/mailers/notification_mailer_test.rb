require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "group_event" do
    mail = NotificationMailer.group_event
    assert_equal "Group event", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
