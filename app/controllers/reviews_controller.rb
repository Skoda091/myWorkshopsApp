class ReviewsController < ApplicationController

  expose(:review)
  expose(:user)
  expose(:product)

  def edit
  end

  def create
    self.review = Review.new(review_params)

    if review.save
      product.reviews << review
      current_user.reviews << review
      flash[:success] = 'Review was successfully created.'
      redirect_to category_product_url(product.category, product)
    else
      render action: 'new'
    end
  end

  def destroy
    review.destroy
    flash[:success] = 'Review was successfully destroyed.'
    redirect_to category_product_url(product.category, product)
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating, :user)
    end
end
