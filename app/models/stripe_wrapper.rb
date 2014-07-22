module StripeWrapper
  class Charge
    attr_reader :amount, :response, :status, :currency
    def initialize response, status, amount, description, currency
      @response = response
      @status = status
      @amount = amount
      @description = description
      @currency = currency
    end

    def self.create options={}
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(amount: options[:amount], currency: 'usd', card: options[:card], description: options[:description])
        
        new response, :success, options[:amount], options[:description], 'usd'
      rescue Stripe::CardError => e
        new e, :error
      end 
    end
  end

  def self.set_api_key
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_SECRET_KEY'] : 'sk_test_4P1NX8fcExkKf0FgRqoznGoI'    
  end  
end