class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    redirect_to admin_dashboards_path, notice: "User has been deactivated"
  end
end
