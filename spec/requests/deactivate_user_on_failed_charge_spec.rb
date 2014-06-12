require 'spec_helper'

describe "Deactivate user on failed charge" do
  let(:event_data) do 
    {
      "id" => "evt_104CsX4tb5cZffxRoAbtRFvh",
      "created" => 1402558655,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_104CsX4tb5cZffxR3IS78a9Q",
          "object" => "charge",
          "created" => 1402558655,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "gbp",
          "refunded" => false,
          "card" => {
            "id" => "card_104CsV4tb5cZffxR35kHGnzz",
            "object" => "card",
            "last4" => "0341",
            "type" => "Visa",
            "exp_month" => 6,
            "exp_year" => 2017,
            "fingerprint" => "PubGhxBySXWAya7l",
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
          "captured" => false,
          "refunds" => [],
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_4CVSp9GltJYJCq",
          "invoice" => nil,
          "description" => "payment failure test",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil,
          "receipt_email" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4CsX8ouH1RKRpO"
    }
  end
  
  it "deactivates a user with webhook data from stripe for failed charge", :vcr do
    foo = Fabricate(:user, customer_token: "cus_4CVSp9GltJYJCq")
    post '/stripe_events', event_data
    expect(foo.reload).not_to be_active
  end
  
end