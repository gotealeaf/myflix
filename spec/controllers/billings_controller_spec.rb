require 'spec_helper'

describe BillingsController do
  describe "GET Show" do
    it "shows the user's previous billing date" do
      jane = Fabricate(:user)
      set_current_user(jane)
      get :show, id: jane.id
      expect(jane.)
    end
    it "shows the user's next billing date"
  end
end