class AddProfileImagetoUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profileImage, :string
  end
end
