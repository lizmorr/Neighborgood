module Admin
  class UsersController < ApplicationController
    def edit
      if current_user.try(:admin?)
        @user = User.find(params[:id])
      else
        redirect_to neighborhoods_path,
          notice: "You don't have access to this page!"
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:notice] = "User updated!"
        redirect_to admin_neighborhoods_path
      end
    end

    def destroy
      @user = User.find(params[:id])
      if @user.destroyable_by?(current_user)
        @user.destroy
        flash[:notice] = "User has been deleted"
        redirect_to admin_neighborhoods_path
      end
    end

    protected

    def user_params
      params.require(:user).permit(:role)
    end
  end
end
