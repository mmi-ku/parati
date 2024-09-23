class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:destroy]

  def index
    @posts = Post.includes(:post_comments)
    if params[:post_id].present?
      @posts = @posts.where(id: params[:post_id])
    else
      @posts = @posts.where("title LIKE ?", "%#{params[:keyword]}%").or(
                 @posts.where("body LIKE ?", "%#{params[:keyword]}%")) if params[:keyword].present?
      @posts = @posts.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    end
    @posts = @posts.page(params[:page]).per(5)
  end

  def destroy
    @post.destroy
    flash[:notice] = "Deteled Post."
    redirect_to admin_posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
