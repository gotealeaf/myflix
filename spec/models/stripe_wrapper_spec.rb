require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      before { StripeWrapper.set_api_key } 

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
          VCR.use_cassette('valid_card') do
            charge = StripeWrapper::Charge.create(amount: 300, card: token)
            expect(charge).to be_successful
            expect(charge.response.amount).to eq(300)
            expect(charge.response.currency).to eq('usd')
          end
        end
      end

      context "with invalid card" do
        let(:card_number) { '4000000000000002' }

        it "does not charge the card" do
          VCR.use_cassette('invalid_card') do
            charge = StripeWrapper::Charge.create(amount: 300, card: token)
            expect(charge).to_not be_successful
          end
        end

        it "contains an error message" do
          VCR.use_cassette('invalid_card') do
            charge = StripeWrapper::Charge.create(amount: 300, card: token)
            expect(charge.error_message).to eq('Your card was declined.')
          end
        end
      end
    end
  end
end