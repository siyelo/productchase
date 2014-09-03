class UsersController < ApplicationController

  def show 
    @user = User.find_by_twitter_username(params[:twitter_username])
    @products = @user.vote_products
  end

end