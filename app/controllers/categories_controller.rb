class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_action :authenticate_admin, only: [:destroy]
  
  expose(:categories)
  expose(:category)
  expose(:name)
  expose(:product) { Product.new }

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    self.category = Category.new(category_params)

    if category.save
      flash[:success] = 'Category was successfully created.'
      redirect_to category
    else
      render action: 'new'
    end
  end

  def update
    if category.update(category_params)
      flash[:success] =  'Category was successfully updated.'
      redirect_to category 
    else
      render action: 'edit'
    end
  end

  def destroy
    category.destroy
    flash[:success] = 'Category was successfully destroyed.'
    redirect_to categories_url
  end

  def authenticate_admin
    if !current_user.admin?
      flash[:error] = 'Permission denied!'
      redirect_to new_user_session_path
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
