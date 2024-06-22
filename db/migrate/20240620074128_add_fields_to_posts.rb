class AddFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :genre, :integer
    add_column :posts, :user_id, :integer
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_column :posts, :product_name, :string
  end
end
