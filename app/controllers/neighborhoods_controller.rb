class NeighborhoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @neighborhoods = Neighborhood.limit(10)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @reviews = @neighborhood.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def new
    @neighborhood = Neighborhood.new
    @errors = @neighborhood.errors
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.user = current_user
    if @neighborhood.save
      redirect_to root_path, notice: "Neighborhood Added!"
    else
      @errors = @neighborhood.errors
      render :new
    end
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
    @errors = @neighborhood.errors
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])
    if @neighborhood.update_attributes(neighborhood_params) &&
        current_user == @neighborhood.user
      redirect_to neighborhood_path(@neighborhood),
        notice: "Neighborhood Edited!"
    else
      @errors = @neighborhood.errors
      render :edit
    end
  end

  protected

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :location, :description)
  end
end
