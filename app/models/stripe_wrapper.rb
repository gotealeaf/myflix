module StripeWrapper
  class Charge
    def initialize(response, error_message) #in relation to new(response)
      @response = response
      @error_message = error_message
      #@error_message = response
    end
    
    def self.create(options={})
      begin
      response = Stripe::Charge.create(
        amount: options[:amount], 
        currency: 'gbp', 
        card: options[:card], 
        description: options[:description]
      )
      new(response, nil) #same as saying Charge.new, we are creating a new instance of the Charge object. We need to pass it into the initializer above
      rescue Stripe::CardError => e
        new(nil, e.message) #when card is declined, we return an object that does not have a response
      end
    end #self.create
    
    def successful?
      @response.present?
    end

    def error_message
      @error_message
    end
    
  end #ends class Charge
    
  class Customer

    attr_accessor :response, :error_message

    def initialize(options={})
      @response = response
      @error_message = error_message
    end

    def self.create(options={})
      begin
        response = Stripe::Customer.create(
          card: options[:card],
          email: options[:user].email
        )
        new(response: response)
      rescue Stripe::CardError => e
        new(error_message: e.message)
      end
    end

    def successful?
      response.present?
    end
  end #ends class Customer
end