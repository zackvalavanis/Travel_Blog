class AddUniqueIndexToLikes < ActiveRecord::Migration[7.1]
  def change
    add_index :likes, [:user_id, :destination_id], unique: true
  end
end
