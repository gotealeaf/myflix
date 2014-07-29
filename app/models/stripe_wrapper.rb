module StripeWrapper
  class Charge

    attr_reader :response, :error_message

    def initialize options={}
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create options={}
      begin
        response = Stripe::Charge.create(
          amount: options[:amount], 
          currency: 'usd', 
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

    def self.set_api_key
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']  
    end 
  end
end