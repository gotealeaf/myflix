require 'spec_helper'

describe QueueItemsController do
  describe 'GET #index' do
    context 'authorized user' do
      it 'sets @queue_items' do
        user  = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    context 'unauthorized user' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
