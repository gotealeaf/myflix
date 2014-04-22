require 'spec_helper'

describe "Deactivate user on failed charge" do
  let(:event_data) do
    {
      "id" => "evt_103typ2aBm1z1KoTmx9M4y0R",
      "created" => 1398199894,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_103typ2aBm1z1KoTdqmfrZBA",
          "object" => "charge",
          "created" => 1398199894,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_103tyn2aBm1z1KoTwvjRJEVa",
            "object" => "card",
            "last4" => "0341",
            "type" => "Visa",
            "exp_month" => 4,
            "exp_year" => 2017,
            "fingerprint" => "kOx73STBgwKdTlKu",
            "customer" => "cus_3tyLWsakuLAtHv",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil
          },
          "captured" => false,
          "refunds" => [],
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_3tyLWsakuLAtHv",
          "invoice" => nil,
          "description" => "Payment to fail",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_3typqVOX3lA4OD"
    }
  end

  it "deactivates a user with the web hook data from stripe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_3tyLWsakuLAtHv")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end