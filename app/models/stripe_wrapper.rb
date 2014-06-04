module StripeWrapper
  class Charge
    attr_reader :response, :status
    def initialize(response, status)
      @response = response
      @status = status
    end
    
    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(amount: options[:amount], currency: 'gbp', card: options[:card], desciption: options[:description])
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end #ends Wrapper rescue 
    end #self.create
    
    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end #ends Charge class
  
  def self.set_api_key
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end
end