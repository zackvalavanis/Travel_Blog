class AddOmniAuthtoUsers < ActiveRecord::Migration[7.1]
    def up
      add_column :users, :provider, :string
      add_column :users, :uid, :string
    end
  
    def down
      remove_column :users, :provider if column_exists?(:users, :provider)
      remove_column :users, :uid if column_exists?(:users, :uid)
    end
end
