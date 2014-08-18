class AddTwitterPic < ActiveRecord::Migration
  def change
    add_column :users, :twitter_pic, :string, null: false, default: 'https://abs.twimg.com/sticky/default_profile_images/default_profile_3_400x400.png'
  end
end
