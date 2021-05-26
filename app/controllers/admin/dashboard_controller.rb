class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]
  # http_basic_authenticate_with name: ENV["USERNAME"], 
  #                              password: ENV["PASSWORD"]
  
  def show
    @products_total = Product.count
    @category_total = Category.count
  end
end
