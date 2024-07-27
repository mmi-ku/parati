class Public:: PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_genre, only: [:index, :new, :edit, :create, :update]
  
  def new
    @post = Post.new
  end
  
  def create
    #byebug
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = 'Successfully shared.'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.includes(:post_comments).page(params[:page]).per(5)
  end

  def show
     @post = Post.find(params[:id])
     @post_comment = PostComment.new
     @Post_comments =@post.post_comments
  end
  
  def edit
    @post = Post.find(params[:id])
    @post_comment = PostComment.find(params[:comment_id])
  end
  
  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = 'Successfully Updated.'
        redirect_to post_path(@post.id)  
      else
        render :show
      end 
  end
  
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_genre
      @genres = Genre.all
    end
  

    def post_params
      params.require(:post).permit(:image, :genre_id, :title, :body)
    end
  
end
