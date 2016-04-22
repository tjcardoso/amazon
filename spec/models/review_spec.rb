require 'rails_helper'

RSpec.describe Review, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it "requires something in the body" do
      r = Review.new FactoryGirl.attributes_for(:review).merge({body: nil})
      expect(r).to be_invalid
    end

    it "requires a star rating" do
      r = Review.new FactoryGirl.attributes_for(:review).merge({stars: nil})
      expect(r).to be_invalid
    end

    it "requires that the star rating be from 0 to 5" do
      r = Review.new FactoryGirl.attributes_for(:review).merge({stars: 10})
      expect(r).to be_invalid
    end

  end
end
