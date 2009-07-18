require 'tls_smtp'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = (RAILS_ENV == "test") ? :test : :smtp
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 587,
  :domain => "support@citizensmarket.org",
  :authentication => :plain,
  :user_name  => "support@citizensmarket.org",
  :password  => "Gcm248248"
}
