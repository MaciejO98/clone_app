class AddLikesColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :int
  end
end
