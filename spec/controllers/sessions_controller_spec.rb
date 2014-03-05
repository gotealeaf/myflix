require 'spec_helper'


describe SessionsController do

  describe 'POST create' do
    
    it "sets the user in the session if user is authenticated" do
      user = Fabricate(:user)

      post :create, {email: user.email, password: user.password}
      expect(session[:user_id]).to eq(user.id)
    end

    it "redirects the user to the new tempate when the password and email are invalid" do
      user = Fabricate(:user)

      post :create, {email: user.email}
      expect(response).to render_template('sessions/new')
    end

    it "sends the user to his dashboard when the user is authenticated" do
      user = Fabricate(:user)

      post :create, {email: user.email, password: user.password}
      user.id == session[:user_id]
      expect(response).to redirect_to videos_path
    end
  end
end