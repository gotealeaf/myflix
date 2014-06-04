require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe '.create' do
      let(:token) { Stripe::Token.create(:card => { :number => "4242424242424242", :exp_month => 6, :exp_year => 2019, :cvc => "314" }).id }
      it 'makes a successful charge' do
        token
      end
    end
  end
end