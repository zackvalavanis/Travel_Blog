class AddUserIdtoDestinations < ActiveRecord::Migration[7.1]
  def change
    add_reference :destinations, :user, foreign_key: true
  end
end
