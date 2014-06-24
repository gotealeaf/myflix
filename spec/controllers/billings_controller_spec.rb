require 'spec_helper'

describe BillingsController do
  describe "GET Show" do
    it "shows the user's previous billing date" do
      jane = Fabricate(:user)
      billing = Fabricate(:payment)
      set_current_user(jane)
      get :show, id: jane.id
      expect(jane.next_billing).to eq(billing.created_at.last)
    end
    
    it "shows the user's next billing date" do
      jane = Fabricate(:user)
      billing = Fabricate(:payment)
      set_current_user(jane)
      get :show, id: jane.id
      expect(jane.next_billing).to eq(billing.created_at + 1.month)
    end
  end
end