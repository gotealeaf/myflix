require 'rails_helper'

describe StripeWrapper do
  let(:stripe_valid_token) do
    Stripe::Token.create(
      card:{
        number: "4242424242424242",
        exp_month: 12,
        exp_year: 2016,
        cvc: 123 }
      )
  end

  let(:stripe_invalid_token) do
    Stripe::Token.create(
      card:{
        number: "4000000000000002",
        exp_month: 12,
        exp_year: 2016,
        cvc: 123 }
      )
  end

  describe StripeWrapper::Charge do
    describe '.create' do
      it 'creates a charge when card is valid', :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: stripe_valid_token.id,
          description: "A valid charge"
        )
        expect(response.successful?).to be_truthy
      end

      it 'does not create a charge when card is not valid', :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: stripe_invalid_token.id,
          description: "An invalid charge"
        )
        expect(response.successful?).to be_falsey
      end

      it 'returns the error message for card error', :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: stripe_invalid_token.id,
          description: "An invalid charge"
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end

  describe StripeWrapper::Customer do
    describe '.create' do
      it 'should create a stripe customer if card is valid', :vcr do
        response = StripeWrapper::Customer.create(
          card: stripe_valid_token.id,
          email: user.email
        )
        expect(response).to be_successful
      end
      it 'returns the stripe_id for a valid card', :vcr do
        response = StripeWrapper::Customer.create(
          card: stripe_valid_token.id,
          email: user.email
        )
        expect(response.stripe_id).to be_present
      end
      it 'should not create a customer if card is not valid', :vcr do
        response = StripeWrapper::Customer.create(
          card: stripe_invalid_token.id,
          email: user.email
        )
        expect(response).not_to be_successful
      end
      it 'returns the error message for card error', :vcr do
        response = StripeWrapper::Customer.create(
          card: stripe_invalid_token.id,
          email: user.email
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end
