class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, with: :not_unique

  before_action :authenticate_user!, except: :show

  def create
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def show
    @product = Product.find_by! id: params[:id]
  end

  def update
    @product = Product.find_by! id: params[:id], user: current_user

    if @product.update product_params
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find_by! id: params[:id], user: current_user
    @product.destroy

    redirect_to products_path
  end

  def new
    @product = Product.new user: current_user
  end

  def edit
    @product = Product.find_by! id: params[:id], user: current_user
  end

  private
  def product_params
    params.require(:product).permit(:link, :name, :description)
  end

  def not_unique exception
    render plain: "#{exception}\nAsk for a manual change.", status: 400
  end
end
