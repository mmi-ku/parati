class AddStarToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :star, :integer
  end
end
