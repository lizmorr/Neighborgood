module Admin
  class UsersController < ApplicationController
    def destroy
      @user = User.find(params[:id])
      if @user.destroyable_by?(current_user)
        @user.destroy
        flash[:notice] = "User has been deleted"
        redirect_to admin_users_path
      end
    end
  end
end
