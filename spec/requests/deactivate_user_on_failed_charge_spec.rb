require 'spec_helper'

describe "Deactivate user on failed charge" do
	let(:event_data) do
		{
		  "id" => "evt_103hCp281FHqYYZYAINfTQui",
		  "created" => 1395253683,
		  "livemode" => false,
		  "type" => "charge.failed",
		  "data" => {
		    "object" => {
		      "id" => "ch_103hCp281FHqYYZYwgo8i0vn",
		      "object" => "charge",
		      "created" => 1395253683,
		      "livemode" => false,
		      "paid" => false,
		      "amount" => 999,
		      "currency" => "usd",
		      "refunded" => false,
		      "card" => {
		        "id" => "card_103hCo281FHqYYZYaY2klQIO",
		        "object" => "card",
		        "last4" => "0341",
		        "type" => "Visa",
		        "exp_month" => 3,
		        "exp_year" => 2017,
		        "fingerprint" => "gMUJiiv9sPOdAW0l",
		        "customer" => "cus_3gpRusboaRSped",
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
		      "customer" => "cus_3gpRusboaRSped",
		      "invoice" => nil,
		      "description" => "payment to fail",
		      "dispute" => nil,
		      "metadata" => {},
		      "statement_description" => nil
		    }
		  },
		  "object" => "event",
		  "pending_webhooks" => 1,
		  "request" => "iar_3hCpD4gPN7KdDM"
		}
	end

	it "deactivates a user with the webhook data from stripe for charge failed", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3gpRusboaRSped")
		post "/stripe_events", event_data
		expect(alice.reload).not_to be_active
	end
end
