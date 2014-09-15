class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:vote][:product])
    @vote = current_user.gives_vote_to(@product)
    redirect_to :back
  end

  def destroy
    Vote.find(params[:id]).destroy
    redirect_to :back
  end
end