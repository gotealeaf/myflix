require 'spec_helper'

describe StripeWrapper do
  
  describe StripeWrapper::Charge do
    
    describe '.create' do
      
      it 'makes a successful charge', :vcr do
        
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
        :card => { 
          :number => "4242424242424242", 
          :exp_month => 6, 
          :exp_year => 2019, 
          :cvc => "314" }
        ).id 
        
        response = StripeWrapper::Charge.create(
          amount: 400,
          currency: "gbp",
          card: token,
          description: "Charge for test@example.com"
        )
        expect(response.amount).to eq(400)
        expect(response.currency).to eq("gbp")
      end #ends it makes a successful charge
    end #ends .create
  end #ends describe StripeWrapper::Charge
end #ends StripeWrapper