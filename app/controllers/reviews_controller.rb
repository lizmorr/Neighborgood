class ReviewsController < ApplicationController
  def index
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @reviews = @neighborhood.reviews
  end
end
