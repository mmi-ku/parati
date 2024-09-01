class Admin::PostCommentsController < ApplicationController
  before_action :set_post, only: [:index, :destroy]
  before_action :set_post_comment, only: [:destroy]
  
  def index
    @post_comments = @post.post_comments
  end
  
  def destroy
    @post_comment.destroy
    redirect_to admin_post_post_comments_path(post_id: @post.id), notice: 'Comment was deleted.'
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])  
  end

  def set_post_comment
    @post_comment = PostComment.find(params[:id]) 
  end
  
end
