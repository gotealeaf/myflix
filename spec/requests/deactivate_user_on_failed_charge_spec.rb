require 'spec_helper'

describe "Deactivate user on failed charge" do
	let(:event_data) do
		{
		  "id" => "evt_103XBZ2bKYmLLeQN128e2I1G",
		  "created" => 1392942589,
		  "livemode" => false,
		  "type" => "charge.failed",
		  "data" => {
		    "object" => {
		      "id" => "ch_103XBZ2bKYmLLeQNsXaDjiCW",
		      "object" => "charge",
		      "created" => 1392942589,
		      "livemode" => false,
		      "paid" => false,
		      "amount" => 999,
		      "currency" => "usd",
		      "refunded" => false,
		      "card" => {
		        "id" => "card_103XBY2bKYmLLeQN5Do1Ahvq",
		        "object" => "card",
		        "last4" => "0341",
		        "type" => "Visa",
		        "exp_month" => 2,
		        "exp_year" => 2016,
		        "fingerprint" => "eaSHh7fepizTkvUh",
		        "customer" => "cus_3WpGQKMsTSdKEf",
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
		      "customer" => "cus_3WpGQKMsTSdKEf",
		      "invoice" => nil,
		      "description" => "Payment to fail",
		      "dispute" => nil,
		      "metadata" => {}
		    }
		  },
		  "object" => "event",
		  "pending_webhooks" => 1,
		  "request" => "iar_3XBZgNGjgRzXy4"
		}
	end

	it "deactivates a user with the web hook data from stripe for a charge failure", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3WpGQKMsTSdKEf")
		post "/stripe_events", event_data
		expect(alice.reload).not_to be_active
	end
end