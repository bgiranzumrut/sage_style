class OrderMailer < ApplicationMailer
  default from: 'no-reply@sandboxa02a0d3bc3d54c01aaacdec67d922f9a.mailgun.org' # Or your Mailgun-verified email

  def confirmation_email(order)
    @order = order
    recipient_email = order.email.presence || order.user&.email

    puts "⚠️ SENDING TO: #{recipient_email}"

    if recipient_email.present?
      mail(to: recipient_email, subject: "Order Confirmation - Sage&Style")
    end
  end
end
