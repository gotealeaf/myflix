require 'rails_helper'

describe 'Suspend access when charge fail' do

  let(:event_data) do
    {
      "id"=> "evt_14XnaQEEWX6SuFHy7KMCsrvx",
      "created"=> 1409550162,
      "livemode"=> false,
      "type"=> "charge.failed",
      "data"=> {
        "object"=> {
          "id"=> "ch_14XnaQEEWX6SuFHy3Kx8uyzF",
          "object"=> "charge",
          "created"=> 1409550162,
          "livemode"=> false,
          "paid"=> false,
          "amount"=> 999,
          "currency"=> "aud",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_14XnZYEEWX6SuFHyBcnIhUlg",
            "object"=> "card",
            "last4"=> "0341",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 9,
            "exp_year"=> 2016,
            "fingerprint"=> "glNUu5jH6pNah22P",
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
            "customer"=> "cus_4g4tUVI4HExuLc"
          },
          "captured"=> false,
          "refunds"=> {
            "object"=> "list",
            "total_count"=> 0,
            "has_more"=> false,
            "url"=> "/v1/charges/ch_14XnaQEEWX6SuFHy3Kx8uyzF/refunds",
            "data"=> []
          },
          "balance_transaction"=> nil,
          "failure_message"=> "Your card was declined.",
          "failure_code"=> "card_declined",
          "amount_refunded"=> 0,
          "customer"=> "cus_4g4tUVI4HExuLc",
          "invoice"=> nil,
          "description"=> "Failed charge",
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> "failed charge",
          "receipt_email"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_4hByzZUkgl3kdQ"
    }
  end
  it 'suspend user access when charge fails', :vcr do
    nelle = Fabricate(:user, stripe_id: 'cus_4g4tUVI4HExuLc')
    post '/stripe_events', event_data
    expect(nelle.reload).not_to be_active
  end
  it 'emails user that access has been suspended', :vcr do
    nelle = Fabricate(:user, stripe_id: 'cus_4g4tUVI4HExuLc')
    post '/stripe_events', event_data
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end
  it 'emails account suspension notice to the correct user', :vcr do
    nelle = Fabricate(:user, stripe_id: 'cus_4g4tUVI4HExuLc')
    post '/stripe_events', event_data
    expect(ActionMailer::Base.deliveries.last.to).to eq([nelle.email])
  end
  it 'emails the correct content to suspended user', :vcr do
    nelle = Fabricate(:user, stripe_id: 'cus_4g4tUVI4HExuLc')
    post '/stripe_events', event_data
    expect(ActionMailer::Base.deliveries.last.body).to include("suspended")
  end
end
