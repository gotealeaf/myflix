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

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    user = User.find_by(stripe_id: event.data.object.customer)
    Payment.create(
                    user: user,
                    amount: event.data.object.amount,
                    reference_id: event.data.object.id
    )
  end
  events.subscribe 'charge.failed' do |event|
    user = User.find_by(stripe_id: event.data.object.customer)
    user.deactivate!
    MyflixMailer.delay.account_suspension(user.id)
  end
end
