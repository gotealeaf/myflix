require 'spec_helper'

describe "Create payment on successful charge" do
	let(:event_data) do
		{
		  "id" => "evt_103gnS281FHqYYZYJ5O3FlEw",
		  "created" => 1395159273,
		  "livemode" => false,
		  "type" => "charge.succeeded",
		  "data" => {
		    "object" => {
		      "id" => "ch_103gnS281FHqYYZYJKuvYUI5",
		      "object" => "charge",
		      "created" => 1395159273,
		      "livemode" => false,
		      "paid" => true,
		      "amount" => 999,
		      "currency" => "usd",
		      "refunded" => false,
		      "card" => {
		        "id" => "card_103gnS281FHqYYZYBXRaD3o1",
		        "object" => "card",
		        "last4" => "4242",
		        "type" => "Visa",
		        "exp_month" => 7,
		        "exp_year" => 2015,
		        "fingerprint" => "4l2bzVeFtauUxEbn",
		        "customer" => "cus_3gnSqDKtY34eov",
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
		      "balance_transaction" => "txn_103gnS281FHqYYZYogmwSGxd",
		      "failure_message" => nil,
		      "failure_code" => nil,
		      "amount_refunded" => 0,
		      "customer" => "cus_3gnSqDKtY34eov",
		      "invoice" => "in_103gnS281FHqYYZYBvveOuGO",
		      "description" => nil,
		      "dispute" => nil,
		      "metadata" => {},
		      "statement_description" => nil
		    }
		  },
		  "object" => "event",
		  "pending_webhooks" => 1,
		  "request" => "iar_3gnSk1QUm1vqWc"
		}
	end

	it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
		post "/stripe_events", event_data
		expect(Payment.count).to eq(1)
	end

	it "creates the payment associated with the user", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3gnSqDKtY34eov")
		post "/stripe_events", event_data
		expect(Payment.first.user).to eq(alice)
	end

	it "creates the payment with the amount", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3gnSqDKtY34eov")
		post "/stripe_events", event_data
		expect(Payment.first.amount).to eq(999)
	end

	it "creates the payment with reference id", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3gnSqDKtY34eov")
		post "/stripe_events", event_data
		expect(Payment.first.reference_id).to eq("ch_103gnS281FHqYYZYJKuvYUI5")
	end
end
