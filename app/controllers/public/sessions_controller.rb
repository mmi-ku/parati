# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reject_inactive_user, only: [:create]

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        redirect_to new_user_session_path, notice: '退会済ユーザーです'
      end
    end
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "Signed in as a guest"
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end

end
