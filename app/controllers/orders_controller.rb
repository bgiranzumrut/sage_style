class OrdersController < ApplicationController
end
class OrdersController < ApplicationController
  before_action :initialize_cart

  def new
    @order = Order.new
    @provinces = Province.all
    @cart_items = Product.find(@cart.keys)
  end

  def create
    @order = Order.new(order_params)
    @order.status = "new"

    subtotal = calculate_subtotal
    tax_rates = get_tax_rates(@order.province_id)
    gst = subtotal * tax_rates[:gst_rate]
    pst = subtotal * tax_rates[:pst_rate]
    hst = subtotal * tax_rates[:hst_rate]
    total = subtotal + gst + pst + hst

    @order.total = total

    if @order.save
      @cart.each do |product_id, quantity|
        product = Product.find(product_id)
        @order.line_items.create!(
          product: product,
          quantity: quantity,
          price_at_purchase: product.price
        )
      end

      session[:cart] = {} # Clear cart after order
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      @provinces = Province.all
      @cart_items = Product.find(@cart.keys)
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def calculate_subtotal
    Product.find(@cart.keys).sum do |product|
      product.price * @cart[product.id.to_s]
    end
  end

  def get_tax_rates(province_id)
    Province.find(province_id).slice(:gst_rate, :pst_rate, :hst_rate)
  end

  def order_params
    params.require(:order).permit(:name, :address, :province_id)
  end
end
