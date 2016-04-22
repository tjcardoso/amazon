require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do

    it "requires a first name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
      expect(u).to be_invalid
    end

    it "requires a last name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({last_name: nil})
      expect(u).to be_invalid
    end

    it "requires an email" do
      u = User.new FactoryGirl.attributes_for(:user).merge({email: nil})
    end

    it "requires the email to unique" do
      u = FactoryGirl.create(:user)
      u.save
      u2 = User.new FactoryGirl.attributes_for(:user).merge({email: u.email})
      expect(u2).to be_invalid
    end

    describe ".full_name and titleized" do
      it "returns concatenated first and last name" do
        u = User.new FactoryGirl.attributes_for(:user).merge({
                                    first_name: "john", last_name: "smith"})
        expect(u.full_name).to eq("John Smith")
      end
    end


  end

end
