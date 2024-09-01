class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_post, only: [:destroy]

  def index
    @posts = Post.includes(:post_comments).page(params[:page]).per(5)
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Deteled Post.'
    redirect_to admin_posts_path
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end
end
