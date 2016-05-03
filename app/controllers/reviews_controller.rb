class ReviewsController < ApplicationController


  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html  {redirect_to product_path(@product), notice: "Review Saved!"}
        format.js {render :create_success}
      else
        flash[:alert] = "Review not saved"
        format.html {render 'products/show'}
        format.js { render js: "alert('failure');"}
      end
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html {redirect_to product_path(@product), notice: "Review Deleted!"}
      format.js {render}
    end
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
