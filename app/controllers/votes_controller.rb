class VotesController < ApplicationController
	before_action :authenticate_user!

	def create
		@product = Product.find(params[:vote][:product])
		@vote = current_user.votes.create(product: @product)
		@user = User.find(params[:vote][:user])
		redirect_to @user
		# respond_to do |format|
		# 	format.html {redirect_to :back}
		# end
	end

	def destroy
		Vote.find(params[:id]).destroy
		@user = User.find(params[:vote][:user])
		redirect_to @user
		# respond_to do |format|
		# 	format.html{redirect_to :back}
		# end
	end
end