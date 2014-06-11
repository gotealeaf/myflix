require 'spec_helper'

describe StripeWrapper do
  
  let(:valid_token) do
    Stripe::Token.create(
      :card => { 
        :number => "4242424242424242", 
        :exp_month => 6, 
        :exp_year => 2019, 
        :cvc => "314" 
      }
    ).id 
  end
  
  let(:declined_token) do
    Stripe::Token.create(
      :card => { 
        :number => "4000000000000002", 
        :exp_month => 6, 
        :exp_year => 2019, 
        :cvc => "314" 
      }
    ).id 
  end
  
  describe StripeWrapper::Charge do
    
    describe '.create' do
      
      it 'makes a successful charge', :vcr do
        
        response = StripeWrapper::Charge.create(
          amount: 400,
          currency: "gbp",
          card: valid_token,
          description: "Charge for test@example.com"
        )
        expect(response.successful?).to be_true
      end #ends it makes a successful charge
      
      it "makes a card declined charge", :vcr do
        
        response = StripeWrapper::Charge.create(
          amount: 400,
          currency: "gbp",
          card: declined_token,
          description: "Charge for test@example.com"
        )
        expect(response.successful?).to be_false
      end
      
      it "returns an error message for declined charge", :vcr do
        
        response = StripeWrapper::Charge.create(
          amount: 400,
          currency: "gbp",
          card: declined_token,
          description: "Charge for test@example.com"
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
      
    end #ends .create
  end #ends describe StripeWrapper::Charge
  
  describe StripeWrapper::Customer do
    
    describe ".create" do
      
      it 'creates a customer with a valid card', :vcr do
        foo = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: foo,
          card: valid_token
        )
        expect(response).to be_successful
      end
      
      it 'returns the customer token for a valid card', :vcr do
        foo = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: foo,
          card: valid_token
        )
        expect(response.customer_token).to be_present
      end
      
      it 'does not create a customer with a declined card', :vcr do
        foo = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: foo,
          card: declined_token
        )
        expect(response).not_to be_successful
      end
      
      it 'returns an error message for a customer with declined card', :vcr do
        foo = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: foo,
          card: declined_token
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end #ends ".create" for StripeWrapper::Customer
  end #ends StripeWrapper::Customer
end #ends StripeWrapper