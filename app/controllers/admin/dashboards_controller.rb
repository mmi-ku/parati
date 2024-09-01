class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
    if params[:keyword].present?
      @users = @users.where('name LIKE ?', "%#{params[:keyword]}%").or(
               @users.where('email LIKE ?', "%#{params[:keyword]}%"))
    elsif params[:user_id].present?
      @users = @users.where(id: params[:user_id])
    end
  end
end
