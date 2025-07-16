class AddBacgroundImageToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :background_image, :string
  end
end
