class OrdersController < ApplicationController
  before_action :initialize_cart

  def new
    @order = Order.new

    if user_signed_in?
      @order.name = "#{current_user.first_name} #{current_user.last_name}"
      @order.address = current_user.address
      @order.province_id = current_user.province_id
      @order.email = current_user.email
    end

    @cart_items = Product.find(@cart.keys)
    @provinces = Province.all

    subtotal = calculate_subtotal
    selected_province = Province.find_by(id: @order.province_id) || Province.first
    tax_rates = selected_province.slice(:gst_rate, :pst_rate, :hst_rate)

    @order.subtotal = subtotal
    @order.gst = subtotal * tax_rates[:gst_rate]
    @order.pst = subtotal * tax_rates[:pst_rate]
    @order.hst = subtotal * tax_rates[:hst_rate]
    @order.total = subtotal + @order.gst + @order.pst + @order.hst
  end

  def create
    @order = user_signed_in? ? current_user.orders.build(order_params) : Order.new(order_params)
    @order.status = "new"

    subtotal = calculate_subtotal
    tax_rates = get_tax_rates(@order.province_id)

    @order.subtotal = subtotal
    @order.gst = subtotal * tax_rates[:gst_rate]
    @order.pst = subtotal * tax_rates[:pst_rate]
    @order.hst = subtotal * tax_rates[:hst_rate]
    @order.total = subtotal + @order.gst + @order.pst + @order.hst

    begin
      charge = Stripe::Charge.create({
        amount: (@order.total * 100).to_i,
        currency: 'cad',
        source: params[:stripeToken],
        description: "Sage&Style Order for #{user_signed_in? ? current_user.email : @order.name}"
      })

      @order.stripe_charge_id = charge.id
      @order.status = "paid"

      if @order.save
        session[:last_order_id] = @order.id if @order.user_id.nil?

        @cart.each do |product_id, quantity|
          product = Product.find(product_id)
          @order.order_items.create!(
            product: product,
            quantity: quantity,
            unit_price: product.price
          )
        end

        #  Send email after saving
        OrderMailer.confirmation_email(@order).deliver_now

        session[:cart] = {}
        redirect_to order_path(@order), notice: "Order placed and payment successful!"
      else
        raise "Order save failed"
      end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      @provinces = Province.all
      @cart_items = Product.find(@cart.keys)
      render :new
    end
  end

  def show
    if user_signed_in?
      @order = current_user.orders.find_by(id: params[:id])
    else
      if session[:last_order_id].to_i == params[:id].to_i
        @order = Order.find_by(id: params[:id], user_id: nil)
      end
    end

    if @order.nil?
      redirect_to root_path, alert: "You don't have permission to view this order."
    end
  end


  def index
    if user_signed_in?
      @orders = current_user.orders.includes(order_items: :product, province: {}).order(created_at: :desc)
    else
      redirect_to root_path, alert: "Please log in to view orders."
    end
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def calculate_subtotal
    Product.find(@cart.keys).sum do |product|
      product.price * @cart[product.id.to_s].to_i
    end
  end

  def get_tax_rates(province_id)
    Province.find(province_id).slice(:gst_rate, :pst_rate, :hst_rate)
  end

  def order_params
    params.require(:order).permit(:name, :address, :province_id, :email)
  end
end
