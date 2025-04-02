class Removeimagesfromdestinations < ActiveRecord::Migration[7.1]
  def change
    remove_column :destinations, :images, :string
  end
end
