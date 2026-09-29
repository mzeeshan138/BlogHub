class AddUniqueIndexToPostsTitle < ActiveRecord::Migration[8.1]
  def change
    add_index :posts, :title, unique: true
  end
end
