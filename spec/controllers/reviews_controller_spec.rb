require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let (:product) {FactoryGirl.create(:product)}
  let (:review) {FactoryGirl.create(:review)}
  let (:user) {FactoryGirl.create(:user)}

    describe '#create' do

    context "without a signed in user" do

      it "redirects to sign up page" do
        post :create, product_id: product.id
        expect(response).to redirect_to new_user_path
      end
    end

    context "with a signed in user" do
      before {request.session[:user_id] = user.id}

      it "renders the new template" do
        post :create, product_id: product.id
        expect(response).to render_template(:new)
      end
    end

    it "associates a review with a user" do
      r = Review.new FactoryGirl.attributes_for(:review)

      expect(r.user_id).to eq(session[:user_id])
    end

  end
end
