require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "should make a charge with valid info", :vcr do
        token = Stripe::Token.create( :card => { :number => "4242424242424242", :exp_month => 4, :exp_year => 2015, :cvc => "314" } ).id
        charge = StripeWrapper::Charge.create( :amount => 400, :card => token, description: 'a valid charge')
        expect(charge).to be_successful
      end
      it "should not make a charge with invalid info", :vcr do
        token = Stripe::Token.create( :card => { :number => "4000000000000002", :exp_month => 4, :exp_year => 2015, :cvc => "314" } ).id
        charge = StripeWrapper::Charge.create( :amount => 400, :card => token, description: 'an invalid charge')
        expect(charge).not_to be_successful
      end
      it "should return error message for declined card", :vcr do
        token = Stripe::Token.create( :card => { :number => "4000000000000002", :exp_month => 4, :exp_year => 2015, :cvc => "314" } ).id
        charge = StripeWrapper::Charge.create( :amount => 400, :card => token, description: 'an invalid charge')
        expect(charge.error_message).to eq("Your card was declined.")
      end
    end
  end
end
