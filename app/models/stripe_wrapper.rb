module StripeWrapper
  class Charge
    def self.create(options={})
      set_stripe_sec_key
      Stripe::Charge.create(
        amount: options[:amount],
        currency: 'aud',
        card: options[:card],
        description: options[:description]
      )
    end

    def self.set_stripe_sec_key
      if Rails.env.development? || Rails.env.test?
        Stripe.api_key = Rails.application.secrets.stripe_sec_key
      else
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      end
    end
  end
end
