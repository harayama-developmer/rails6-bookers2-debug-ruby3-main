class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :conversation_users, dependent: :destroy
  has_many :conversations, through: :conversation_users
  has_many :messages, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_events, dependent: :destroy

  has_many :following_relationships,
    class_name: "Relationship",
    foreign_key: "follower_id",
    inverse_of: "follower",
    dependent: :destroy

  has_many :followings,
    through: :following_relationships,
    source: :followed

  has_many :follower_relationships,
    class_name: "Relationship",
    foreign_key: "followed_id",
    inverse_of: "followed",
    dependent: :destroy

  has_many :followers,
    through: :follower_relationships,
    source: :follower

  has_many :owned_groups,
    class_name: "Group",
    foreign_key: "owner_id",
    inverse_of: :owner,
    dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(other_user)
    following_relationships.create(followed: other_user)
  end

  def unfollow(other_user)
    followings.delete(other_user)
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def followed?(other_user)
    followers.include?(other_user)
  end

  def mutual_follow?(other_user)
    following?(other_user) && followed?(other_user)
  end
end
