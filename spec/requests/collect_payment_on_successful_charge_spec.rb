require 'spec_helper'

describe "Create payment on successful charge" do
	let(:event_data) do
		{
		  "id" => "evt_103WRy2bKYmLLeQNs7a7dDcx",
		  "created" => 1392772995,
		  "livemode" => false,
		  "type" => "invoice.payment_succeeded",
		  "data" => {
		    "object" => {
		      "date" => 1392772995,
		      "id" => "in_103WRy2bKYmLLeQNqsQuek1U",
		      "period_start" => 1392772995,
		      "period_end" => 1392772995,
		      "lines" => {
		        "object" => "list",
		        "count" => 1,
		        "url" => "/v1/invoices/in_103WRy2bKYmLLeQNqsQuek1U/lines",
		        "data" => [
		          {
		            "id" => "sub_3WRyiDiHCbBxAC",
		            "object" => "line_item",
		            "type" => "subscription",
		            "livemode" => false,
		            "amount" => 999,
		            "currency" => "usd",
		            "proration" => false,
		            "period" => {
		              "start" => 1392772995,
		              "end" => 1395192195
		            },
		            "quantity" => 1,
		            "plan" => {
		              "interval" => "month",
		              "name" => "The Base Plan",
		              "created" => 1392771009,
		              "amount" => 999,
		              "currency" => "usd",
		              "id" => "base",
		              "object" => "plan",
		              "livemode" => false,
		              "interval_count" => 1,
		              "trial_period_days" => nil,
		              "metadata" => {}
		            },
		            "description" => nil,
		            "metadata" => nil
		          }
		        ]
		      },
		      "subtotal" => 999,
		      "total" => 999,
		      "customer" => "cus_3WRyfgX5rfmeD6",
		      "object" => "invoice",
		      "attempted" => true,
		      "closed" => true,
		      "paid" => true,
		      "livemode" => false,
		      "attempt_count" => 0,
		      "amount_due" => 999,
		      "currency" => "usd",
		      "starting_balance" => 0,
		      "ending_balance" => 0,
		      "next_payment_attempt" => nil,
		      "charge" => "ch_103WRy2bKYmLLeQNchSNG1xK",
		      "discount" => nil,
		      "application_fee" => nil,
		      "subscription" => "sub_3WRyiDiHCbBxAC",
		      "metadata" => {}
		    }
		  },
		  "object" => "event",
		  "pending_webhooks" => 1,
		  "request" => "iar_3WRyAZFfn2ce0m"
		}
	end
	it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
		post "/stripe_events", event_data
		expect(Payment.count).to eq(1)
	end

	it "creates the payment associated with the user", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3WRyfgX5rfmeD6")
		post "/stripe_events", event_data
		expect(Payment.first.user).to eq(alice)
	end

	it "creates the payment with the amount", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3WRyfgX5rfmeD6")
		post "/stripe_events", event_data
		expect(Payment.first.amount).to eq(999)
	end

	it "creates the payment with reference id", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3WRyfgX5rfmeD6")
		post "/stripe_events", event_data
		expect(Payment.first.reference_id).to eq("in_103WRy2bKYmLLeQNqsQuek1U")
	end
end