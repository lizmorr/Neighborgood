module Admin
  class NeighborhoodsController < ApplicationController
    def index
      if current_user.try(:admin?)
        @neighborhoods = Neighborhood.page(params[:page]).per(10)
        @neighborhood = Neighborhood.new
        @users = User.page(params[:page]).per(10)
      else
        redirect_to neighborhoods_path,
          notice: "You don't have access to this page!"
      end
    end

    def create
      @neighborhood = Neighborhood.new(neighborhood_params)
      @neighborhood.user = current_user
      if @neighborhood.save
        redirect_to admin_neighborhoods_path, notice: "Neighborhood Added!"
      else
        flash[:alert] = @neighborhood.errors.full_messages.join("\n")
        render :index
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
      params.require(:neighborhood).permit(:name, :location, :description, :image)
    end
  end
end
