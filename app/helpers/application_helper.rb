module ApplicationHelper
  def percentage(after, before)
    return "- %" if before.zero?

    num = (after / before.to_f * 100).round
    "#{num} %"
  end
end
