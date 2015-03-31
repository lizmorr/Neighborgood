class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.all.limit(10)
  end
end
