module Admin
  class UsersController < ApplicationController
    def edit
      @user = User.find(params[:id])
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
        params.require(:user).permit(:role, :image)
      end
  end
end
