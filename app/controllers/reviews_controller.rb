class ReviewsController < ApplicationController


  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: "Review Saved!"
    else
      flash[:alert] = "Review not saved"
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product), notice: "Review Deleted!"
  end

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end

  private

  def user_like
    @user_like ||= @review.like_for(current_user)
  end


  def review_params
    params.require(:review).permit(:body, :stars)
  end

end
