class UsersController < ApplicationController
  prepend_view_path "app/views/products"

  def show 
    @user = User.find_by_twitter_username(params[:twitter_username])
    @products = @user.vote_products
    @product = @products[0]
  end

end