class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_one_attached :image

  validates :name, presence: true

  before_create :default_image

  def default_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end

  def get_image(width, height)
    default_image
    image.variant(resize_to_limit: [width, height]).processed
  end

  def owner?(user)
    owner_id == user.id
  end
end
