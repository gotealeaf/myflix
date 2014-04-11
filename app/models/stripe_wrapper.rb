module StripeWrapper
  class Charge
    def self.create(options={})
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          card: options[:card],
          description: options[:description]
        )
    end
  end
end
