require 'spec_helper'
require 'pry'

describe FollowshipsController do
  describe 'POST #create' do
    context 'user is logged in' do
      let(:adam) { Fabricate(:user) }
      let(:follower) { Fabricate(:user) }
      before do
        add_to_session(adam)
      end
      it 'creates a new followship' do
        post :create, follower_ids: follower.id
        expect(Followship.count).to eq(1)
      end
      it 'doesnt let it follow someone more than once' do
        Fabricate(:followship, user: adam, follower: follower)
        post :create, follower_ids: follower.id
        expect(Followship.count).to eq(1)
      end
      it 'displays a confirmation message if the follow is successful' do
        post :create, follower_ids: follower.id
        expect(flash[:success]).to be_present
      end
      it 'shows an error message if the save wasnt successful' do
        Fabricate(:followship, user: adam, follower: follower)
        post :create, follower_ids: follower.id
        expect(flash[:danger]).to be_present
      end
      it 'redirects the user to the followships index page' do
        post :create, follower_ids: follower.id
        expect(response).to redirect_to followships_path
      end
      it 'doesnt let a user follow themselves' do
        post :create, follower_ids: adam.id
        expect(Followship.count).to eq(0)
      end
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :create, follower_ids: [{user_id: 1, follower_id: 2}] }
    end
  end

  describe 'GET #index' do
    it 'gets all the users followships' do
      adam = Fabricate(:user)
      add_to_session(adam)
      follower1 = Fabricate(:user)
      follower2 = Fabricate(:user)
      Fabricate(:followship, user: adam, follower: follower1)
      Fabricate(:followship, user: adam, follower: follower2)
      get :index
      expect(assigns(:users_followers)).to eq([follower1, follower2])
    end
    it 'renders the template' do
      adam = Fabricate(:user)
      add_to_session(adam)
      follower1 = Fabricate(:user)
      follower2 = Fabricate(:user)
      Fabricate(:followship, user: adam, follower: follower1)
      Fabricate(:followship, user: adam, follower: follower2)
      get :index
      response.should render_template(:index)
    end
  end

  describe 'POST #destroy' do
    let(:adam) { Fabricate(:user) }
    let(:follower) { Fabricate(:user) }
    before do
      add_to_session(adam)
    end
    it 'destroys existing followships' do
      followship = Fabricate(:followship, user_id: adam.id, follower: follower)
      post :destroy, id: follower.id
      expect(Followship.count).to eq(0)
    end
    it 'displays an error message if the there was no followship to delete' do
      post :destroy, id: 1
      expect(flash[:danger]).to be_present
    end
    it 'displays a confirmation message if the delete is completed successfully' do
      Fabricate(:followship, user_id: adam.id, follower: follower )
      post :destroy, id: follower.id
      expect(flash[:success]).to be_present
    end
    it 'redirects the user to the index page for followships' do
      followship = Fabricate(:followship, user_id: adam.id)
      post :destroy, id: followship.id
      expect(response).to redirect_to followships_path
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :destroy, id: 1 }
    end
  end
end
