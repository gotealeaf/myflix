module StripeWrapper
  class Charge
    attr_reader :response, :status

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: "usd",
          card: options[:card]
        )
        new(response: response)
      rescue Stripe::CardError => e 
        new(error_message: e.message)
      end
    end

    def successful?
      response.present?
    end
  end

  def self.set_api_key
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end
end