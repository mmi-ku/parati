class Public:: PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:edit, :update, :destroy]
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
  
    if comment.save
      flash[:notice] = 'Your Review is Successfully Shared.'
      redirect_to post_path(post)
    else
      flash.now[:alert] = 'Failed to share the comment.'
      render 'public/posts/show'
    end
  end
  
  def edit
    @post= @post_comment.post
  end
  
  def update
    if @post_comment.update(post_comment_params)
      redirect_to post_path(@post_comment.post), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post_comment.destroy
    redirect_to post_path(@post_comment.post), notice: 'Comment was successfully deleted.'
  end

  private
  
  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment, :star)
  end
end
