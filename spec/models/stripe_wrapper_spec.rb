require 'rails_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe '.create' do
      context 'if card is accepted' do
        it 'creates a charge', :vcr do
          response = StripeWrapper::Charge.create(
            amount: 999,
            card: stripe_valid_token.id,
            description: "A valid charge"
          )
          expect(response.amount).to eq(999)
          expect(response.currency).to eq('aud')
        end
      end
    end
  end
end
