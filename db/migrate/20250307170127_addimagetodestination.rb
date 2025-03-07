class Addimagetodestination < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :images, :string
  end
end
