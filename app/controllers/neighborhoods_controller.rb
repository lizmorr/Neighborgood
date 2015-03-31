class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.all.limit(10)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
  end
end
