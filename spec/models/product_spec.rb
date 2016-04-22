require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "validations" do
    it "requires a title and price" do
      c = Product.new(description: "blah")
      validation_outcome = c.valid?
      expect(validation_outcome).to eq(false)
    end

    it "requires that title is unique" do
      Product.create title: "hello", price: 2, sale_price: 1
      c1 = Product.new title: "hello", price: 2, sale_price: 1
      c1.valid?
      expect(c1.errors).to have_key(:title)
    end

    it "requires a sale price" do
      c = Product.new(title: "hello", price: 2)
      result = c.default_sale_price
      expect(result).to eq(c.price)
    end

    it "requires that sale price be less than or equal to price" do
      c = Product.new(title: "hello", price: 10, sale_price: 12)

      result = c.on_sale?
      expect(result).to eq(false)
    end




  end


end
