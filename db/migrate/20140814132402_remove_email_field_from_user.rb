class RemoveEmailFieldFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :email, :string, null: false, default: ''
  end
end
