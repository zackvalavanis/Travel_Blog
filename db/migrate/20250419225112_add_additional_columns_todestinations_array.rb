class AddAdditionalColumnsTodestinationsArray < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :State, :string
  end
end
