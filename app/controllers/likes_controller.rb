class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :review

  def create

    like         = Like.new
    @product      = Product.find params[:product_id]
    like.user    = current_user
    like.review  = review
    respond_to do |format|

      if like.save
        format.html {redirect_to product_path(product), notice: "Thanks for liking!"}
        format.js {render}
      else
        format.html {redirect_to product_path(product), alert: "Already liked!"}
        format.js {render js: "alert('Cant like, please refresh the page!')"}
      end
    end
  end

  def destroy

    @product = Product.find params[:product_id]
    review  = Review.find params[:review_id]
    like    = current_user.likes.find params[:id]
    like.destroy
    respond_to do |format|
      format.html {redirect_to product_path(product), notice: "Like removed!"}
      format.js {render }
    end
  end

  def review
    @review ||= Review.find params[:review_id]
  end

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end
end
