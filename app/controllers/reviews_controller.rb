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

  def edit
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @review = Review.find(params[:id])
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
      flash[:alert] = @review.errors.full_messages.join("\n")
      render "neighborhoods/show"
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review updated!"
      redirect_to neighborhood_path(@review.neighborhood_id)
    else
      flash[:alert] = @review.errors.full_messages.join("\n")
      redirect_to edit_neighborhood_review_path(@review.neighborhood, @review)
    end
  end

  def destroy
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
