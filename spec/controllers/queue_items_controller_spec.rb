require 'spec_helper'

describe QueueItemsController do
  describe 'GET index' do
    it 'sets @queue_items for logged in user' do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      get :index
      q1 = Fabricate(:queue_item, user: bob)
      q2 = Fabricate(:queue_item, user: bob)
      expect(assigns(:queue_items)).to match_array([q1, q2])
    end
    it 'redirects unauthenticated users to sign in page' do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
end
