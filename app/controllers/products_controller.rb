class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  #should happen first

  before_action(:find_product, {only: [:show, :edit, :update, :destroy]})
  
    def new
      # we need to define a new 'Product' object in order to be able to
      # properly generate form in Rails
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      @product.user = current_user

      if @product.save
        flash[:notice] = "Product Created!"
        # redirect_to product_path({id: @product.id})
        redirect_to product_path(@product)

      else
        flash[:alert] = "Product didn't save"
        # this will render '/app/views/products/new.html.erb' becasue the default
        # in this action is to render 'app/views/products/create.html.erb'
        render 'new'

      end
    end

    def show
      @product = Product.find params[:id]
      @review = Review.new
    end

    def index
      @products = Product.all
    end

    def edit
      @product = Product.find params[:id]
    end

    def update
      if @product.update product_params
        # flash messages can be set either direclty use: flash[:notice] = ".."
        # you can also pass ':notice' or ':alert 'options to the 'redirect_to'
        # method
        redirect_to product_path(@product), notice: "#{@product.title} updated!"
      else
        render 'edit'
      end
    end

    def destroy
      @product = Product.find params[:id]
      @product.destroy
      redirect_to products_path
    end

    private

    def find_product
      @product = Product.find params[:id]
    end

    def product_params
      params.require(:product).permit([:title, :body, :category_id, :price, :sale_price])
    end



end
