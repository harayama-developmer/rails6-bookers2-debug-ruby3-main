class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, uniqueness: { scope: :user_id }

  scope :week, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }
end
