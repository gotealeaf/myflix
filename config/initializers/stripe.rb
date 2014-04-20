if Rails.env.production?
  Rails.configuration.stripe = { :publishable_key => ENV['STRIPE_LIVE_PUBLISH_KEY'],
                                 :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY'] }
else
  Rails.configuration.stripe = { :publishable_key => ENV['STRIPE_TEST_PUBLISH_KEY'],
                                 :secret_key      => ENV['STRIPE_TEST_SECRET_KEY'] }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
