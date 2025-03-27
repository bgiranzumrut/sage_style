class WelcomeController < ApplicationController
  def index
    @featured_products = Product.featured
    @all_products = Product.all
  end
end
