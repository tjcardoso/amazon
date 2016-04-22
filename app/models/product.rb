class Product < ActiveRecord::Base

  before_validation :default_sale_price

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true
  validates :sale_price, presence: true, numericality: {less_than_or_equal_to: :price}

  belongs_to :category
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  def favorited_by?(user)
    favorites.find_by_user_id(user.id).present?
  end

  def on_sale?
    sale_price < price
  end

  def favorite_for(user)
    favorites.find_by_user_id user if user
  end

  def user_full_name
    user ? user.full_name.titleize : ""
  end

  def default_sale_price
    self.sale_price ||= price
  end

  private

  def titleize_title
    self.title = title.titleize
  end

end
