class RenamePostImageIdColumnToPostComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :post_image_id, :post_id
  end
end
