require 'rails_helper'

describe StripeWrapper do
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
end
