Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.setup do
  subscribe 'charge.succeeded' do |event|
    found_user = User.where(stripe_customer: event.data.object.customer).first
    Payment.create(user: found_user, amount: event.data.object.amount, reference: event.data.object.id)
  end

  subscribe 'charge.failed' do |event|
    found_user = User.where(stripe_customer: event.data.object.customer).first
    found_user.update_column(:locked, true)
    AppMailer.delay.send_customer_locked_email(found_user.email, found_user.full_name)
  end
end