require 'rails_helper'

describe InvitesController do
  describe 'POST Create' do
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { post :create, id: 1 }
    end
    context 'when user is authenticated' do
      before { set_session_user }
      context 'when fields are blank' do
        it 'redirects to invite page' do
          post :create, invite: [{ friend_name: '', friend_email: '' }]
          expect(response).to redirect_to invite_path
        end
        it 'flashes error message' do
          post :create, invite: [{ friend_name: '', friend_email: '' }]
          expect(flash[:danger]).to eq("Fields can't be empty")
        end
      end
      context 'when email is not valid' do
        it 'redirects to invite page' do
          post :create, invite: [{ friend_name: 'john', friend_email: 'john.com' }]
          expect(response).to redirect_to invite_path
        end
        it 'flashes error message' do
          post :create, invite: [{ friend_name: 'john', friend_email: 'john.com' }]
          expect(flash[:danger]).to eq('Please enter a valid email')
        end
      end
      context 'when inputs are valid' do
        before { set_session_user }
        it 'assigns @token' do
          post :create, invite: [{ message: 'some message', friend_name: 'Nelle', friend_email: 'nelle@example.com' }]
          expect(assigns(:token)).to eq(user.user_tokens.first)
        end
        it 'assigns @friend_name' do
          user_inputs = { "message" => 'some message', "friend_name" => 'Nelle', "friend_email" => 'nelle@example.com' }
          post :create, invite: [user_inputs]
          expect(assigns(:friend_name)).to eq('Nelle')
        end
        it 'assigns @friend_email' do
          user_inputs = { "message" => 'some message', "friend_name" => 'Nelle', "friend_email" => 'nelle@example.com' }
          post :create, invite: [user_inputs]
          expect(assigns(:friend_email)).to eq('nelle@example.com')
        end
        it 'assigns @msg' do
          user_inputs = { "message" => 'some message', "friend_name" => 'Nelle', "friend_email" => 'nelle@example.com' }
          post :create, invite: [user_inputs]
          expect(assigns(:msg)).to eq('some message')
        end

        it 'delivers email to @friend_email' do
          post :create, invite: [{ message: 'some message', friend_name: 'Nelle', friend_email: 'nelle@example.com' }]
          expect(ActionMailer::Base.deliveries.last.to).to eq(['nelle@example.com'])
        end
        it 'redirects to home page' do
          post :create, invite: [{ message: 'some message', friend_name: 'Nelle', friend_email: 'nelle@example.com' }]
          expect(response).to redirect_to home_path
        end
      end
    end
  end
end
