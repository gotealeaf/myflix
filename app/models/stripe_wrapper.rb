module StripeWrapper
  class Charge

    attr_reader :response, :error_message

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      set_stripe_sec_key
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'aud',
          card: options[:card],
          description: options[:description]
        )
        new(response: response)
      rescue Stripe::CardError => e
        new(error_message: e.message)
      end
    end

    def successful?
      response.present?
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
