class HomeController < ApplicationController
  def index
    @products_by_day = ProductGrouping.new Product.last_n_days(3)
  end
end
