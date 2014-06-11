require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
    {
      "id" => "evt_104CVS4tb5cZffxRRFgxS6Ve",
      "created" => 1402472781,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_104CVS4tb5cZffxRN42z2Jrw",
          "object" => "charge",
          "created" => 1402472781,
          "livemode" => false,
          "paid" => true,
          "amount" => 999,
          "currency" => "gbp",
          "refunded" => false,
          "card" => {
            "id" => "card_104CVS4tb5cZffxRKbkvw2ND",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 6,
            "exp_year" => 2016,
            "fingerprint" => "VfkQZgiLeMQDObnc",
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
            "address_zip_check" => nil,
            "customer" => "cus_4CVSp9GltJYJCq"
          },
          "captured" => true,
          "refunds" => [],
          "balance_transaction" => "txn_104CVS4tb5cZffxRrMEy5Txg",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_4CVSp9GltJYJCq",
          "invoice" => "in_104CVS4tb5cZffxRScQjHfNV",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => "MyFlix monthly"
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4CVSUHW1kZ5ONx"
    }
  end
  
  it "creates a payment with the webhook from stripe for successful charge", :vcr do
    post '/stripe_events', event_data
    expect(Payment.count).to eq(1)
  end
  
  it "creates the payment associated with the user", :vcr do
    bob = Fabricate(:user, customer_token: "cus_4CVSp9GltJYJCq")
    post '/stripe_events', event_data
    expect(Payment.first.user).to eq(bob)
  end
  
  it "creates the payment associated with the amount", :vcr do
    bob = Fabricate(:user, customer_token: "cus_4CVSp9GltJYJCq")
    post '/stripe_events', event_data
    expect(Payment.first.amount).to eq(999)
  end
  
  it "creates the payment with reference id", :vcr do
    bob = Fabricate(:user, customer_token: "cus_4CVSp9GltJYJCq")
    post '/stripe_events', event_data
    expect(Payment.first.reference_id).to eq("ch_104CVS4tb5cZffxRN42z2Jrw")
  end
end