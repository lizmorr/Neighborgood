class NeighborhoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @neighborhoods = Neighborhood.order(:name).page(params[:page]).per(10)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @reviews = @neighborhood.
      reviews.
      order(created_at: :desc).
      page(params[:page]).
      per(25)
    @review = Review.new
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])
    if @neighborhood.editable_by?(current_user) &&
        @neighborhood.update_attributes(neighborhood_params)
      redirect_to neighborhood_path(@neighborhood),
        notice: "Neighborhood Edited!"
    else
      flash[:alert] = @neighborhood.errors.full_messages.join("\n")
      render :edit
    end
  end

  protected

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :location, :description, :image)
  end
end
