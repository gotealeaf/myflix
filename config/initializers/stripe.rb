Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.setup do
  subscribe 'charge.succeeded' do |event|
    payment = Payment.new
    found_user = User.where(stripe_customer: event.data.object.customer).first
    payment.user = found_user
    payment.amount = event.data.object.amount
    payment.reference = event.data.object.id
    payment.save
  end

  subscribe 'charge.failed' do |event|
    found_user = User.where(stripe_customer: event.data.object.customer).first
    found_user.locked = true
    found_user.save(validate: false)
    AppMailer.delay.send_customer_locked_email(found_user.email, found_user.full_name)
  end
end