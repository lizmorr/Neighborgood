module Admin
  class UsersController < ApplicationController
    def update
      @user = User.find(params[:id])
      if @user.editable_by?(current_user)
        if @user.admin?
          @user.set_member
          flash[:notice] = "User Demoted to Member!"
          redirect_to admin_neighborhoods_path
        else
          @user.set_admin
          flash[:notice] = "User Promoted to Admin!"
          redirect_to admin_neighborhoods_path
        end
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
  end
end
