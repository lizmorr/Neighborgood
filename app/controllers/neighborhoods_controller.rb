class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.all.limit(10)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    if @neighborhood.save
      redirect_to root_path, notice: "Neighborhood Added!"
    else
      render :new
    end
  end

  protected

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :location, :description)
  end
end
