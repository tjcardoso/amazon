class User < ActiveRecord::Base
  has_secure_password

  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    name = "#{first_name} #{last_name}"
    name.titleize
  end

  def titleize(string)
    string.split(" ").map {|x| x.capitalize}
  end
  private

end
