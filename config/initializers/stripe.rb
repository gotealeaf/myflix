Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.configure do |events|
  events.subscribe 'invoice.payment_succeeded' do |event|
    # Define subscriber behavior based on the event object
    user = User.where(customer_token: event.data.object.customer).first
    Payment.create(user: user, amount: event.data.object.total, reference_id: event.data.object.id)
  end

  events.subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    user = User.where(customer_token: event.data.object.customer).first
    user.deactivate!
  end

  events.all do |event|
    # Handle all event types - logging, etc.
  end
end