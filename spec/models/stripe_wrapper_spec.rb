require 'spec_helper'

describe StripeWrapper, vcr: true do
  describe StripeWrapper::Charge do
    describe ".create" do
      let(:token) do
        Stripe::Token.create(
          :card => {
            :number => card_number,
            :exp_month => 3,
            :exp_year => 2020,
            :cvc => 314
          }
        ).id
      end

      context "with valid card" do
        let(:card_number) { '4242424242424242' }
        
        it "charges the card successfully" do
          charge = StripeWrapper::Charge.create(amount: 300, card: token)
          expect(charge.successful?).to be_true
        end
      end

      context "with invalid card" do
        let(:card_number) { '4000000000000002' }

        it "does not charge the card" do
          charge = StripeWrapper::Charge.create(amount: 300, card: token)
          expect(charge.successful?).to_not be_true
        end

        it "contains an error message" do
          charge = StripeWrapper::Charge.create(amount: 300, card: token)
          expect(charge.error_message).to eq('Your card was declined.')
        end
      end
    end
  end
end