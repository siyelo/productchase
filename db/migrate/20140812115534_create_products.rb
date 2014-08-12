class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :link, null: false
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_index :products, :link, unique: true
  end
end
