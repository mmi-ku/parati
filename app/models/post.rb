class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  belongs_to :genre, optional: true
  
  
  
  validates :image, presence: true
  validates :title, presence: true
  validates :body, presence: true
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg' 
    end
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
