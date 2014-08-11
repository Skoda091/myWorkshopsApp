class ProductsController < ApplicationController
  before_action :owner_of_the_product, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
     @products = category.products
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    self.product = Product.new(product_params)

    if product.save
      category.products << product
      current_user.products << product
      flash[:success] = 'Product was successfully created.'
      redirect_to category_product_url(category, Product.last)
    else
      render action: 'new'
    end
  end

  def update
    if self.product.update(product_params)
      flash[:success] = 'Product was successfully updated.'
      redirect_to category_product_url(category, product)
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    flash[:success] = 'Product was successfully destroyed.'
    redirect_to category_url(category)
  end

  def owner_of_the_product
    if current_user != product.user
      flash[:error] = "You are not allowed to edit this product."
      redirect_to category_product_url(category, product)
    end  
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end
end
