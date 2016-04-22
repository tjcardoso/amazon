class LikesController < ApplicationController
  before_action :authenticate_user!

  def create

    like         = Like.new
    review       = Review.find params[:review_id]
    product      = Product.find params[:product_id]
    like.review  = review
    like.user    = current_user
    if like.save
      redirect_to product_path(product), notice: "Thanks for liking!"
    else
      redirect_to product_path(product), alert: "Already liked!"
    end
  end

  def destroy

    product = Product.find params[:product_id]
    review  = Review.find params[:review_id]
    like    = current_user.likes.find params[:id]
    like.destroy
    redirect_to product_path(product), notice: "Like removed!"
  end

end
