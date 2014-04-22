require 'spec_helper'

describe StripeWrapper do
  let(:valid_token) do
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 4,
        :exp_year => 2018,
        :cvc => "314"
      },
    ).id
  end

  let(:declined_card_token) do
    Stripe::Token.create(
      :card => {
        :number => "4000000000000002",
        :exp_month => 4,
        :exp_year => 2018,
        :cvc => "314"
      },
    ).id
  end

  describe StripeWrapper::Charge do
    describe ".create" do
      it "makes a successful charge", :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: valid_token,
          description: "a valid charge"
        )
        expect(response).to be_successful
      end

      it "makes a card declined charge", :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: declined_card_token,
          description: "an invalid charge"
        )
        expect(response).not_to be_successful
      end

      it "returns the error messages for declined charges", :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: declined_card_token,
          description: "an invalid charge"
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end

  describe StripeWrapper::Customer do
    describe ".create" do
      it "creates a cutomer with a valid card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: valid_token,
        )
        expect(response).to be_successful
      end

      it "does not create a customer with a declined card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: declined_card_token,
        )
        expect(response).not_to be_successful
      end

      it "returns the error messages for declined card", :vcr do
        alice = Fabricate(:user)        
        response = StripeWrapper::Customer.create(
          user: alice,
          card: declined_card_token,
        )
        expect(response.error_message).to eq("Your card was declined.")
      end

      it "returns the customer token for a valid card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: valid_token,
        )
        expect(response.customer_token).to be_present
      end
    end
  end
end
