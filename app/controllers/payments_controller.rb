

class PaymentsController < ApplicationController
  def new
  end

  def charge
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    Stripe::Charge.create({
      amount: 2000, # amount in cents ($20.00)
      currency: 'usd',
      source: params[:stripeToken], # gets token from form
      description: 'Test charge from Sage&Style'
    })

    flash[:notice] = "Payment successful!"
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payments_new_path
  end
end
