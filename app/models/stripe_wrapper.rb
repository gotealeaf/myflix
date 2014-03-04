module StripeWrapper
  class Charge
    attr_reader :response, :error_message
    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: "usd",
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
  end

  class Customer
    attr_reader :customer, :error_message
    def initialize(options={})
      @customer = options[:customer]
      @error_message = options[:error_message]
    end 

    def self.create(options={})
      begin
        customer = Stripe::Customer.create(
          card: options[:card],
          plan: "basic",
          email: options[:email]
        )
        new(customer: customer)
      rescue Stripe::CardError => e
        new(error_message: e.message)
      end
    end

    def successful?
      customer.present?
    end
  end
end