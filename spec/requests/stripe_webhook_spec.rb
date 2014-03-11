require "spec_helper"

describe "Stripe Webhook", :vcr do
  describe "payment successful" do
    let(:event_data) do {
      "id" => "evt_103ba12Px4Wvfu2AlXDVkBos",
      "created" => 1393956132,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_103ba12Px4Wvfu2Ao7PWbkiG",
          "object" => "charge",
          "created" => 1393956132,
          "livemode" => false,
          "paid" => true,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_103ba12Px4Wvfu2A86HUmpl7",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 3,
            "exp_year" => 2016,
            "fingerprint" => "jgFh3FXSqUbvxQj6",
            "customer" => "cus_3ba1qrCz26qEni",
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
          "balance_transaction" => "txn_103ba12Px4Wvfu2Av0kxtFYO",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_3ba1qrCz26qEni",
          "invoice" => "in_103ba12Px4Wvfu2AJbEEjPWb",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {}
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_3ba1hOGpEf4j68"
    }
    end
    it "creates a payment with the Stripe Webhook" do
      post "/stripe_events", event_data
      expect(Payment.count).to eq(1)
    end
    it "associates the record with the user" do
      alice = Fabricate(:user, stripe_customer: "cus_3ba1qrCz26qEni")
      post "/stripe_events", event_data
      expect(Payment.last.user).to eq(alice)
    end
    it "moves the correct amount to the Payment field" do
      alice = Fabricate(:user, stripe_customer: "cus_3ba1qrCz26qEni")
      post "/stripe_events", event_data
      expect(Payment.last.amount).to eq(999)
    end
    it "moves the payment reference to the Reference field" do
      alice = Fabricate(:user, stripe_customer: "cus_3ba1qrCz26qEni")
      post "/stripe_events", event_data
      expect(Payment.last.reference).to eq("ch_103ba12Px4Wvfu2Ao7PWbkiG")
    end
  end
  describe "payment failed" do
    let(:event_data) do {
      "id" => "evt_103bzo2Px4Wvfu2APLOs6F2V",
      "created" => 1394052029,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_103bzo2Px4Wvfu2AFiYs8f1A",
          "object" => "charge",
          "created" => 1394052029,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_103bzk2Px4Wvfu2AIea9QJeK",
            "object" => "card",
            "last4" => "0341",
            "type" => "Visa",
            "exp_month" => 3,
            "exp_year" => 2019,
            "fingerprint" => "cLTQIQTuD28cDlU9",
            "customer" => "cus_3bcdc3Bt8RhLE1",
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
          "customer" => "cus_3bcdc3Bt8RhLE1",
          "invoice" => nil,
          "description" => "Test Fail",
          "dispute" => nil,
          "metadata" => {}
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_3bzoaE6YEekuzY"
    }
    end
    it "locks the customer record" do
      alice = Fabricate(:user, stripe_customer: "cus_3bcdc3Bt8RhLE1")
      post "/stripe_events", event_data
      expect(alice.reload.locked).to eq(true)
    end
    it "sends an email to the customer" do
      ActionMailer::Base.deliveries.clear
      alice = Fabricate(:user, stripe_customer: "cus_3bcdc3Bt8RhLE1")
      post "/stripe_events", event_data
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end