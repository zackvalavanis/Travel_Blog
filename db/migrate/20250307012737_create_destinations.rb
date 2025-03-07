class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :country
      t.string :city
      t.text :description

      t.timestamps
    end
  end
end
