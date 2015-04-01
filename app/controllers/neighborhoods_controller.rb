class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.limit(10)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.user_id = current_user.id
    if @neighborhood.save
      redirect_to root_path, notice: "Neighborhood Added!"
    else
      flash[:alert] = "Your neighborhood was not saved"
      render :new
    end
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])
    if @neighborhood.update_attributes(neighborhood_params) &&
      current_user.id == @neighborhood.user_id
      redirect_to neighborhood_path(@neighborhood),
        notice: "Neighborhood Edited!"
    else
      flash[:alert] = "Your neighborhood was not saved"
      render :edit
    end
  end

  protected

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :location, :description)
  end
end
