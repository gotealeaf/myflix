require 'spec_helper'


describe SessionsController do
  describe 'GET new'
    it "redirects the user away from the log in page if user is authenticated"
      session[:user_id] = Fabricate(:user).id

      get :new
      expect(response).to redirect_to videos_path
    end

    it "sets the user in the session when the password and email are valid"
    it "redirects the user to the videos path when the password and email are valid"
end