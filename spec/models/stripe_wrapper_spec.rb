require "spec_helper"

describe StripeWrapper do
  describe StripeWrapper::Charge do
    before do
      StripeWrapper.set_api_key
    end
    describe ".create" do
      context "with valid card" do
        it "charges the card successfully", :vcr do
          token = Stripe::Token.create(
            :card => {
              :number => "4242424242424242",
              :exp_month => 2,
              :exp_year => 2018,
              :cvc => "314"
              }
            ).id
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: token,
            description: "a valid charge"
          )
          
          expect(response.successful?).to eq(true)
        end
      end
      context "with invalid card" do
        it "charge successful should be false", :vcr do
          token = Stripe::Token.create(
            :card => {
              :number => "4000000000000002",
              :exp_month => 2,
              :exp_year => 2018,
              :cvc => "314"
              }
            ).id
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: token,
            description: "an invalid charge"
          )
          
          expect(response.successful?).to eq(false)
        end
        it "returns an error message", :vcr do
          token = Stripe::Token.create(
            :card => {
              :number => "4000000000000002",
              :exp_month => 2,
              :exp_year => 2018,
              :cvc => "314"
              }
            ).id
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: token,
            description: "an invalid charge"
          )
          
          expect(response.error_message).to eq("Your card was declined.")
        end
      end
    end
  end
end