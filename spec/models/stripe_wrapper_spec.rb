require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "makes a successful charge", :vcr do
        token = Stripe::Token.create( 
          :card => { 
            :number => "4242424242424242", 
            :exp_month => 4, 
            :exp_year => 2017, 
            :cvc => "314" 
          }, 
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          desciption: "a valid charge"
        )

        expect(response).to be_successful
      end

      it "makes a card declined charge", :vcr do
        token = Stripe::Token.create( 
          :card => { 
            :number => "4000000000000002", 
            :exp_month => 4, 
            :exp_year => 2017, 
            :cvc => "314" 
          }, 
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          desciption: "an invalid charge"
        )

        expect(response).not_to be_successful
      end

      it "returns the error message for declined charges", :vcr do
        token = Stripe::Token.create( 
          :card => { 
            :number => "4000000000000002", 
            :exp_month => 4, 
            :exp_year => 2017, 
            :cvc => "314" 
          }, 
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          desciption: "an invalid charge"
        )

        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end