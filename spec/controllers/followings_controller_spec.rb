require 'rails_helper'

describe FollowingsController do
  describe 'GET #index' do
    it 'assigns @followings variable when user is authenticated' do
      set_session_user
      followee = Fabricate(:user)
      followings = Fabricate(:following, user: user, followee: followee)
      get :index
      expect(assigns(:followings)).to eq([followings])
    end
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :index }
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'should create a following' do
        set_session_user
        followee = Fabricate(:user)
        post :create, user_id: followee.id
        expect(Following.count).to eq(1)
      end
      it 'should not create a following if use is already following followee' do
        set_session_user
        followee = Fabricate(:user)
        followings = Fabricate(:following, user: user, followee: followee)
        post :create, user_id: followee.id
        expect(Following.count).to eq(1)
      end

      it 'should not create a following of self' do
        set_session_user
        post :create, user_id: user.id
        expect(Following.count).to eq(0)
      end
      it 'should associate a following to current user' do
        set_session_user
        followee = Fabricate(:user)
        post :create, user_id: followee.id
        expect(Following.first.user_id).to eq(user.id)
      end
      it 'should associate a following to followee' do
        set_session_user
        followee = Fabricate(:user)
        post :create, user_id: followee.id
        expect(Following.first.followee_id).to eq(followee.id)
      end
      it 'should redirect to people page' do
        set_session_user
        followee = Fabricate(:user)
        post :create, user_id: followee.id
        expect(response).to redirect_to people_path
      end
    end
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { post :create, user_id: 1 }
    end
  end

  describe 'DELETE #destroy'do
    context 'when user is authenticate' do
      it 'should redirect to people page' do
        set_session_user
        followee = Fabricate(:user)
        following = Fabricate(:following, user: user, followee: followee)
        delete :destroy, id: followee.id
        expect(response).to redirect_to people_path
      end

      it 'should flash a message on success' do
        set_session_user
        followee = Fabricate(:user)
        following = Fabricate(:following, user: user, followee: followee)
        delete :destroy, id: followee.id
        expect(flash[:success]).to eq("You are no longer following #{ followee.full_name }")
      end
      it 'should delete followee from people list' do
        set_session_user
        followee = Fabricate(:user)
        following = Fabricate(:following, user: user, followee: followee)
        delete :destroy, id: followee.id
        expect(Following.count).to eq(0)
      end
      it 'should not delete followee if not on people list' do
        set_session_user
        other_user = Fabricate(:user)
        followee = Fabricate(:user)
        following = Fabricate(:following, user: other_user, followee: followee)
        delete :destroy, id: followee.id
        expect(Following.count).to eq(1)
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { delete :destroy, id: 1 }
    end

  end
end
