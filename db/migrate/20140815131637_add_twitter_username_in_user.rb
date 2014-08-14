class AddTwitterUsernameInUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_username, :string, null: true

    add_index :users, :twitter_username, unique: true
  end
end
