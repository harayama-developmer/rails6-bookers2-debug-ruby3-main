module Footprintable
  extend ActiveSupport::Concern

  included do
    has_many :footprints, as: :footprintable, dependent: :delete_all
  end

  def footprint!(visited_user)
    return unless visited_user

    footprints.find_or_create_by(user: visited_user) if user != visited_user
  end
end