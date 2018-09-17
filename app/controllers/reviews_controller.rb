class ReviewsController < ApplicationController
  before_filter :login

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user_id = session[:user_id]
    @review.save
    redirect_to "/products/#{params[:product_id]}"
  end

  def destroy
    Review.delete(params[:id])
    redirect_to product_path(params[:pid])
  end

    private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
