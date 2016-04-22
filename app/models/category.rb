class Category < ActiveRecord::Base
  has_many :products, dependent: :nullify
  validates :name, presence: true, uniqueness: true
end
