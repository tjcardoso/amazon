class FavoritesController < ApplicationController
  before_action :authenticate_user!

    def create
      favorite          = Favorite.new
      product           = Product.find params[:product_id]
      favorite.product  = product
      favorite.user     = current_user
      if favorite.save
        redirect_to product_path(product), notice: "You've added it to your favorites!"
      else
        redirect_to product_path(product), alert: "Can't favorite! Favorited already?"
      end
    end
    def destroy
      favorite.destroy
      redirect_to product_path(favorite.product_id), notice: "Un-favorited!"
    end

    private

    def authorize_create
      redirect_to product, notice: "Can't favorite!" unless can? :favorite, product
    end

    def authorize_destroy
      redirect_to product, notice: "Can't remove favorite!" unless can? :destroy, favorite
    end

    def product
      @product ||= Product.find params[:product_id]
    end

    def favorite
      @favorite ||= Favorite.find params[:id]
    end

end
