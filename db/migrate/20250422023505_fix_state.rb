class FixState < ActiveRecord::Migration[7.1]
  def change
    rename_column :destinations, :State, :state
  end
end
