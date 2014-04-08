require 'spec_helper'

describe "deactivate user on failed charge" do
  let(:event_data) do
    {
    "id"=> "evt_103oUL2JANYh9MVFH2bSEQWI",
    "created"=> 1396933332,
    "livemode"=> false,
    "type"=> "charge.failed",
    "data"=> {
      "object"=> {
        "id"=> "ch_103oUL2JANYh9MVF7QG6vZqB",
        "object"=> "charge",
        "created"=> 1396933332,
        "livemode"=> false,
        "paid"=> false,
        "amount"=> 999,
        "currency"=> "usd",
        "refunded"=> false,
        "card"=> {
          "id"=> "card_103oUK2JANYh9MVFK0DTpq5z",
          "object"=> "card",
          "last4"=> "0341",
          "type"=> "Visa",
          "exp_month"=> 4,
          "exp_year"=> 2016,
          "fingerprint"=> "BUojGsB2zKuzsWp5",
          "customer"=> "cus_3oMnNjGP2KFQ0J",
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
        "captured"=> false,
        "refunds"=> [],
        "balance_transaction"=> nil,
        "failure_message"=> "Your card was declined.",
        "failure_code"=> "card_declined",
        "amount_refunded"=> 0,
        "customer"=> "cus_3oMnNjGP2KFQ0J",
        "invoice"=> nil,
        "description"=> "payment fail",
        "dispute"=> nil,
        "metadata"=> {},
        "statement_description"=> nil
      }
    },
    "object"=> "event",
    "pending_webhooks"=> 1,
    "request"=> "iar_3oUL4KFcHeWJVe"
  }
  end

  it "should deactivate user with the webhook from stripe for charge failed", :vcr do
    desmond = Fabricate(:user, customer_token: "cus_3oMnNjGP2KFQ0J")
    post '/stripe_event', event_data
    expect(desmond.reload).not_to be_active
  end
end
