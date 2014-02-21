module StripeWrapper
  class Charge
    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

  	def self.create(options={})
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
      @response.present?
    end

    def error_message
      @error_message
    end
  end

  class Customer
    attr_reader :response, :error_message

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        response = Stripe::Customer.create(
          card: options[:card],
          email: options[:user].email,
          plan: "base"
          )
        new(response: response)
      rescue Stripe::CardError => e
        new(error_message: e.message)
      end
    end

    def successful?
      response.present?
    end

    def customer_token
      response.id
    end
  end
end