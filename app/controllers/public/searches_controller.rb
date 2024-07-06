class Public:: SearchesController < ApplicationController
    before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
        @users = User.looks(params[:search], params[:word])
    elsif @range == "Post"
        @posts = Post.looks(params[:search], params[:word])
    elsif @range == "Genre"
        @genres = Genre.looks(params[:search], params[:word])
        @posts = Post.where(genre_id: @genres.pluck(:id))
    end
  end

end
