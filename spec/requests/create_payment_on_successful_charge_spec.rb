require 'spec_helper'

describe "Create payment on successful charge" do
  let (:event_data) do
    {
      "id" => "evt_103tgP2aBm1z1KoTOumVlRoJ",
      "created" => 1398131402,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_103tgP2aBm1z1KoTFkAPsURw",
          "object" => "charge",
          "created" => 1398131402,
          "livemode" => false,
          "paid" => true,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_103tgP2aBm1z1KoTC0qyRFv1",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 4,
            "exp_year" => 2015,
            "fingerprint" => "jxt5UvtpyqyJjD9H",
            "customer" => "cus_3tgP50PMbwLWqD",
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
          "captured" => true,
          "refunds" => [],
          "balance_transaction" => "txn_103tgP2aBm1z1KoTbch0y4HT",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_3tgP50PMbwLWqD",
          "invoice" => "in_103tgP2aBm1z1KoTLl5pkp2U",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => "MyFlix Monthly"
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_3tgPyktEY0usZ0"
    }
  end
    
  it "creates a payment with the webhook from stripe for charge succeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with the user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_3tgP50PMbwLWqD")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_3tgP50PMbwLWqD")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_3tgP50PMbwLWqD")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_103tgP2aBm1z1KoTFkAPsURw")
  end
end