class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, with: :not_unique

  def create
    @product = Product.new product_params

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]

    if @product.update product_params
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.destroy params[:id]

    redirect_to products_path
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find params[:id]
  end

  private
  def product_params
    params.require(:product).permit(:link, :name, :description)
  end

  def not_unique exception
    render plain: "#{exception}\nAsk for a manual change.", status: 400
  end
end
