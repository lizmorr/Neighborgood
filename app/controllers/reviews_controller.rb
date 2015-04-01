class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @reviews = @neighborhood.reviews.order(created_at: :desc)
  end

  def new
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = Review.new
  end

  def create
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = Review.create(review_params)
    @review.neighborhood = @neighborhood
    @review.user = current_user
    if @review.save
      flash[:notice] = "Review added successfully."
      redirect_to neighborhood_path(@neighborhood)
    else
      flash[:alert] = "Review not added."
      render "neighborhoods/show"
    end
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
