class Public:: PostCommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
  
    if comment.save
      flash[:notice] = 'Your Review is Successfully Shared.'
      redirect_to post_path(post)
    else
      flash.now[:alert] = 'Failed to share the comment.'
      render :show
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :star)
  end
end
