class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@sandboxa02a0d3bc3d54c01aaacdec67d922f9a.mailgun.org'  # or your Mailgun email
  layout 'mailer'
end
