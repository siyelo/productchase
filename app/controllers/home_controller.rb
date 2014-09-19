class HomeController < ApplicationController
  def index
    @products_by_day = ProductGrouping.new Product.n_days_worth 3
  end
end
