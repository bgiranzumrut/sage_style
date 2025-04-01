class CartController < ApplicationController
  before_action :load_cart

  def show
    @cart_items = Product.find(@cart.keys)
  end

  def add
    id = params[:id].to_s
    @cart[id] ||= 0
    @cart[id] += 1
    save_cart
    redirect_to cart_path, notice: "Product added to cart"
  end

  def remove
    @cart.delete(params[:id].to_s)
    save_cart
    redirect_to cart_path, notice: "Item removed"
  end

  def update
    params[:quantities]&.each do |id, quantity|
      if quantity.to_i <= 0
        @cart.delete(id)
      else
        @cart[id] = quantity.to_i
      end
    end
    save_cart
    redirect_to cart_path, notice: "Cart updated"
  end

  private

  def load_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def save_cart
    session[:cart] = @cart
  end
end
