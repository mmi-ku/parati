class UserImagesController < ApplicationController
  
  def new 
    @user_image = UserImage.new
  end
  
  def create
    @user_image = UserImage.new(user_image_params)
    @user_image.user_id = current_user.id
    @user_image.save
    redirect_to user_images_path
  end
  
  def index
  end

  def show
  end
  
  private

  def user_image_params
    params.require(:user_image).permit(:image)
  end
  
end
