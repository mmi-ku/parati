class ChangeDataGenreToPost < ActiveRecord::Migration[6.1]
  def up
    add_reference :posts, :genre, foreign_key: true
  end
end
