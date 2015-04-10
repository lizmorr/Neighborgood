class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = @neighborhood.reviews.find(params[:id])
  end

  def create
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = Review.new(review_params)
    @review.neighborhood = @neighborhood
    @review.user = current_user

    if @review.save
      ReviewNotifier.new_review(@review).deliver
      flash[:notice] = "Review added successfully."
      redirect_to neighborhood_path(@neighborhood)
    else
      @errors = @review.errors.full_messages
      render "neighborhoods/show"
    end
  end

  def update
    @review = Review.find(params[:id])
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    if @review.update(review_params)
      flash[:notice] = "Review updated!"
      redirect_to neighborhood_path(@review.neighborhood_id)
    else
      @errors = @review.errors.full_messages
      render :edit
    end
  end

  def destroy
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = Review.find(params[:id])
    if @review.user == current_user || current_user.admin?
      @review.destroy
      flash[:notice] = "Review deleted"
      redirect_to neighborhood_path(@neighborhood)
    end
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
