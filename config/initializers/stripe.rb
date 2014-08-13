if Rails.env.staging? || Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: Rails.application.secrets.stripe_pub_key,
    secret_key: Rails.application.secrets.stripe_sec_key
  }
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]
