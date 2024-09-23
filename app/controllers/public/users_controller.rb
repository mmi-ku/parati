class Public:: UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated profile successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path, notice: "Your account has been deleted successfully."
  end

  private
    def correct_user
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to user_path(@user), alert: "You are not authorized to edit this user's profile."
      end
    end

    def current_user?(user)
      user == current_user
    end

    def user_params
      params.require(:user).permit(:name, :profile_image)
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.guest_user?
        redirect_to user_path(current_user), notice: "Guest can't shift to the profile edit page."
      end
    end
end
