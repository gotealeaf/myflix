require 'spec_helper'


describe SessionsController do

  describe 'GET new' do
    it "redirects the user away from the log in page if user is authenticated"
    it "sets the user in the session when the password and email are valid"
    it "redirects the user to the videos path when the password and email are valid"
  end
end