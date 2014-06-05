require 'spec_helper'

describe StripeWrapper do
  
  describe StripeWrapper::Charge do
    
    describe '.create' do
      
      it 'makes a successful charge', :vcr do
        
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
        expect(response.successful?).to be_true
      end #ends it makes a successful charge
      
      it "makes a card declined charge", :vcr do
        
        token = Stripe::Token.create(
        :card => { 
          :number => "4000000000000002", 
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
        expect(response.successful?).to be_false
      end
      
      it "returns an error message for declined charge", :vcr do
        
        token = Stripe::Token.create(
        :card => { 
          :number => "4000000000000002", 
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
        expect(response.error_message).to eq("Your card was declined.")
      end
      
    end #ends .create
  end #ends describe StripeWrapper::Charge
end #ends StripeWrapper