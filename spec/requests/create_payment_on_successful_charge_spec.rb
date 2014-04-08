require 'spec_helper'

describe "create payment on successfull charge" do
  let(:event_data) do
    {
      "id"=> "evt_103oL22JANYh9MVFnuF3ndMa",
      "created"=> 1396898713,
      "livemode"=> false,
      "type"=> "charge.succeeded",
      "data"=> {
        "object"=> {
          "id"=> "ch_103oL22JANYh9MVF6Nbd7dUk",
          "object"=> "charge",
          "created"=> 1396898713,
          "livemode"=> false,
          "paid"=> true,
          "amount"=> 999,
          "currency"=> "usd",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_103oL22JANYh9MVFwaBz9Mjo",
            "object"=> "card",
            "last4"=> "4242",
            "type"=> "Visa",
            "exp_month"=> 4,
            "exp_year"=> 2015,
            "fingerprint"=> "xtjBEsATD6l3c4KY",
            "customer"=> "cus_3oL2ehExWX1gPR",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil
          },
          "captured"=> true,
          "refunds"=> [],
          "balance_transaction"=> "txn_103oL22JANYh9MVF9gCKhc0j",
          "failure_message"=> nil,
          "failure_code"=> nil,
          "amount_refunded"=> 0,
          "customer"=> "cus_3oL2ehExWX1gPR",
          "invoice"=> "in_103oL22JANYh9MVFFbgcaxOV",
          "description"=> nil,
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_3oL2z9gALmsy6j"
    }
  end
  it "should create a payment with the webhook from stripe for charge succeeded", :vcr do
    post '/stripe_event', event_data
    expect(Payment.count).to eq(1)
  end

  it "should create a payment with associated user", :vcr do
    desmond = Fabricate(:user, customer_token: "cus_3oL2ehExWX1gPR")
    post '/stripe_event', event_data
    expect(Payment.first.user).to eq(desmond)
  end

  it "should create a payment with amount", :vcr do
    desmond = Fabricate(:user, customer_token: "cus_3oL2ehExWX1gPR")
    post '/stripe_event', event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "should create a payment with reference id", :vcr do
    desmond = Fabricate(:user, customer_token: "cus_3oL2ehExWX1gPR")
    post '/stripe_event', event_data
    expect(Payment.first.reference_id).to eq("ch_103oL22JANYh9MVF6Nbd7dUk")
  end
end
