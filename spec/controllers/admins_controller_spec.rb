require 'spec_helper'

describe AdminsController do
  describe 'ensure_admin' do
    it "redirects to root path if the user is not an admin" do
      ana = Fabricate :user, admin: false
      set_current_user ana

      get 'ensure_admin'

      expect(reponse).to redirect_to root_path
    end
  end
end