class WelcomeController < ApplicationController
  def index
    @featured_products = Product.featured
  end
end
