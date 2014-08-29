require 'rails_helper'

describe 'Create payment on successful charge' do

  let(:event_data) do
    {
      "id"=> "evt_14WfYQEEWX6SuFHyQ2oa1aOn",
      "created"=> 1409280958,
      "livemode"=> false,
      "type"=> "charge.succeeded",
      "data"=> {
        "object"=> {
          "id"=> "ch_14WfYQEEWX6SuFHyC7JpYszt",
          "object"=> "charge",
          "created"=> 1409280958,
          "livemode"=> false,
          "paid"=> true,
          "amount"=> 999,
          "currency"=> "aud",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_14WfYFEEWX6SuFHywRXPA22k",
            "object"=> "card",
            "last4"=> "4242",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 8,
            "exp_year"=> 2016,
            "fingerprint"=> "hjWFn5h9EJtWX9XC",
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
            "address_zip_check"=> nil,
            "customer"=> "cus_4g1b5nSipBzUzE"
          },
          "captured"=> true,
          "refunds"=> {
            "object"=> "list",
            "total_count"=> 0,
            "has_more"=> false,
            "url"=> "/v1/charges/ch_14WfYQEEWX6SuFHyC7JpYszt/refunds",
            "data"=> []
          },
          "balance_transaction"=> "txn_14WfYQEEWX6SuFHyqfWQNng8",
          "failure_message"=> nil,
          "failure_code"=> nil,
          "amount_refunded"=> 0,
          "customer"=> "cus_4g1b5nSipBzUzE",
          "invoice"=> "in_14WfYQEEWX6SuFHyx6JYJ2GQ",
          "description"=> nil,
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> "MyFlix bill",
          "receipt_email"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_4g1bC7fgwIEwTi"
    }
  end

  it "creates payment with Stripe webhook charge.succeeded", :vcr do
    post '/stripe_events', event_data
    expect(Payment.count).to eq(1)
  end

  it 'creates a payment associated with the user', :vcr do
    user = Fabricate(:user, stripe_id: 'cus_4g1b5nSipBzUzE')
    post '/stripe_events', event_data
    expect(Payment.first.user).to eq(user)
  end

  it 'creates a payment with the correct amount', :vcr do
    post '/stripe_events', event_data
    expect(Payment.first.amount).to eq(999)
  end

  it 'creates a payment with the correct reference_id', :vcr do
    post '/stripe_events', event_data
    expect(Payment.first.reference_id).to eq('ch_14WfYQEEWX6SuFHyC7JpYszt')
  end
end
