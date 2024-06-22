class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :image, presence: true
  validates :genre, presence: true
  validates :title, presence: true
  validates :body, presence: true
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg' 
    end
  end
end
