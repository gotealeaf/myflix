require 'spec_helper'

describe StripeWrapper::Charge do 
  before do 
    StripeWrapper.set_api_key
  end

  let(:token) do
    Stripe::Token.create(
      :card => {
        :number => card_number,
        :exp_month => 3,
        :exp_year => Time.new.year + 1, # keeps the credit card year valid
        :cvc => 123
      }
    ).id
  end

  context "with valid card" do 
    let(:card_number) { '4242424242424242' }

    it "charges the card successfully" do
      response = VCR.use_cassette 'Stripe Charge' do
        StripeWrapper::Charge.create(amount: 300, card: token)
      end
      response.should be_successful
    end
  end
  context "with invalid card" do 
    let(:card_number) { '4000000000000002' }
    let(:response) do
      VCR.use_cassette('Stripe Invalid Card') do 
        StripeWrapper::Charge.create(amount: 300, card: token)
      end
    end

    it "does not charge the card successfully" do
      response.should_not be_successful
    end
  end
end
