class RemoveProductNameFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :product_name, :string
  end
end
