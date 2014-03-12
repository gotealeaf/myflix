require "spec_helper"

describe StripeWrapper do
  let(:valid_token) do
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 2,
        :exp_year => 2018,
        :cvc => "314"
      }
    ).id
  end
  let(:declined_card_token) do
    Stripe::Token.create(
      :card => {
        :number => "4000000000000002",
        :exp_month => 2,
        :exp_year => 2018,
        :cvc => "314"
      }
    ).id
  end
  describe StripeWrapper::Charge do
    describe ".create" do
      context "with valid card" do
        it "charges the card successfully", :vcr do
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: valid_token,
            description: "a valid charge"
          )
          expect(response).to be_successful
        end
      end
      context "with invalid card" do
        it "charge successful should be false", :vcr do
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: declined_card_token,
            description: "an invalid charge"
          )
          expect(response).not_to be_successful
        end
        it "returns an error message", :vcr do
          response = StripeWrapper::Charge.create(
            amount: 999, 
            card: declined_card_token,
            description: "an invalid charge"
          )
          expect(response.error_message).to eq("Your card was declined.")
        end
      end
    end
  end
  describe StripeWrapper::Customer do
    describe ".create" do
      context "with valid card" do
        it "charges the card successfully", :vcr do
          response = StripeWrapper::Customer.create(
            card: valid_token,
            email: "alice@example.com"
          )
          expect(response).to be_successful
        end
        it "returns the customer ID", :vcr do
          response = StripeWrapper::Customer.create(
            card: valid_token,
            email: "alice@example.com"
          )
          expect(response.stripe_customer).to be_present
        end
      end
      context "with invalid card" do
        it "does not create a customer", :vcr do
          response = StripeWrapper::Customer.create(
            card: declined_card_token,
            email: "alice@example.com"
          )
          expect(response).not_to be_successful
        end
        it "returns an error message", :vcr do
          response = StripeWrapper::Customer.create(
            card: declined_card_token,
            email: "alice@example.com"
          )
          expect(response.error_message).to eq("Your card was declined.")
        end
      end
    end
  end
end