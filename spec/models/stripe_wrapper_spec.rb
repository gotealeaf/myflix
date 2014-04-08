require 'spec_helper'

describe StripeWrapper do
  let(:valid_token) { Stripe::Token.create( :card => { :number => "4242424242424242", :exp_month => 4, :exp_year => 2015, :cvc => "314" } ).id }
  let(:invalid_token) { Stripe::Token.create( :card => { :number => "4000000000000002", :exp_month => 4, :exp_year => 2015, :cvc => "314" } ).id }
  describe StripeWrapper::Charge do
    describe ".create" do
      it "should make a charge with valid info", :vcr do
        charge = StripeWrapper::Charge.create( :amount => 400, :card => valid_token, description: 'a valid charge')
        expect(charge).to be_successful
      end
      it "should not make a charge with declined card", :vcr do
        charge = StripeWrapper::Charge.create( :amount => 400, :card => invalid_token, description: 'an invalid charge')
        expect(charge).not_to be_successful
      end
      it "should return error message for declined card", :vcr do
        charge = StripeWrapper::Charge.create( :amount => 400, :card => invalid_token, description: 'an invalid charge')
        expect(charge.error_message).to eq("Your card was declined.")
      end
    end
  end

  describe StripeWrapper::Customer do
    describe ".create" do
      it "should create a customer with valid card", :vcr do
        desmond = Fabricate(:user)
        response = StripeWrapper::Customer.create(:card => valid_token,user: desmond)
        expect(response).to be_successful
      end
      it "should not create a customer with declined card", :vcr do
        desmond = Fabricate(:user)
        response = StripeWrapper::Customer.create(:card => invalid_token,user: desmond)
        expect(response).not_to be_successful
      end
      it "should return error message for declined card", :vcr do
        desmond = Fabricate(:user)
        response = StripeWrapper::Customer.create(:card => invalid_token,user: desmond)
        expect(response.error_message).to eq("Your card was declined.")
      end
      it "should return customer token for valid", :vcr do
        desmond = Fabricate(:user)
        response = StripeWrapper::Customer.create(:card => valid_token,user: desmond)
        expect(response.customer_token).to be_present
      end
    end
  end
end
