module StripeWrapper
  class Charge
    def self.create(options={})
      Stripe::Charge.create(
        amount: options[:amount], 
        currency: 'gbp', 
        card: options[:card], 
        description: options[:description]
      )
    end #self.create
    
    #def successful?
      #status == :success
    #end

    #def error_message
      #response.message
    #end
  end #ends Charge class
  
  #def self.set_api_key
    #Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  #end
end