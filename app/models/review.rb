class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :body, presence: true
  validates :stars, presence: true, inclusion: {in: 0..5, message: "The star value should be between 0 to 5"}

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end

  def like_for(user)
    likes.find_by_user_id user if user
  end
  
  def full_name
    user ? user.full_name : ""
  end
end
