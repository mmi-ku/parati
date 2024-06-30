class UsersController < ApplicationController
  def index
    
  end

  def show
     @user = User.find(params[:id])
     @posts = @user.posts
  end

  def edit
    @user= User.find(params[:id])
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
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :user_image)
  end
  
  
end
