class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart

  def new
    @order = Order.new(
      name: current_user.first_name + " " + current_user.last_name,
      address: current_user.address,
      province_id: current_user.province_id
    )
    @cart_items = Product.find(@cart.keys)
    @provinces = Province.all
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "new"

    subtotal = calculate_subtotal
    tax_rates = get_tax_rates(@order.province_id)

    @order.subtotal = subtotal
    @order.gst = subtotal * tax_rates[:gst_rate]
    @order.pst = subtotal * tax_rates[:pst_rate]
    @order.hst = subtotal * tax_rates[:hst_rate]
    @order.total = subtotal + @order.gst + @order.pst + @order.hst

    if @order.save
      @cart.each do |product_id, quantity|
        product = Product.find(product_id)
        @order.order_items.create!(
          product: product,
          quantity: quantity,
          unit_price: product.price
        )
      end

      session[:cart] = {}
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      @provinces = Province.all
      @cart_items = Product.find(@cart.keys)
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @orders = current_user.orders.includes(order_items: :product, province: {})
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
