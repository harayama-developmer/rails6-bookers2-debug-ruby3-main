class Footprint < ApplicationRecord
  belongs_to :user
  belongs_to :footprintable, polymorphic: true
end
