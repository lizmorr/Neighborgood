module Admin
  class NeighborhoodsController < ApplicationController
    def index
      @neighborhoods = Neighborhood.page(params[:page]).per(10)
    end

    def new
      if current_user.try(:admin?)
        @neighborhood = Neighborhood.new
      else
        redirect_to neighborhoods_path,
          notice: "You don't have access to this page!"
      end
    end

    def create
      @neighborhood = Neighborhood.new(neighborhood_params)
      @neighborhood.user = current_user
      if @neighborhood.save
        redirect_to neighborhoods_path, notice: "Neighborhood Added!"
      else
        flash[:alert] = @neighborhood.errors.full_messages.join("\n")
        render :new
      end
    end

    def destroy
      @neighborhood = Neighborhood.find(params[:id])
      if @neighborhood.destroyable_by?(current_user)
        @neighborhood.destroy
        flash[:notice] = "Neighborhood has been deleted"
        redirect_to admin_neighborhoods_path
      end
    end

    protected

    def neighborhood_params
      params.require(:neighborhood).permit(:name, :location, :description)
    end
  end
end
