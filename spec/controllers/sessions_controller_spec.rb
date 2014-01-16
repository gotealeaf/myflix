require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'redirect to the home path if current_user' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    it 'renders the new template for uncurrent_user' do
      get :new
      expect(response).to  render_template :new
    end
  end
end
