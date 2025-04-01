class CartController < ApplicationController
  before_action :initialize_cart

  def add
    id = params[:id].to_s
    @cart[id] = (@cart[id] || 0) + 1
    save_cart
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove
    @cart.delete(params[:id].to_s)
    save_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update
    params[:quantities].each do |id, quantity|
      quantity = quantity.to_i
      if quantity <= 0
        @cart.delete(id)
      else
        @cart[id] = quantity
      end
    end
    save_cart
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def show
    @cart_items = Product.find(@cart.keys)
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def save_cart
    session[:cart] = @cart
  end
end
