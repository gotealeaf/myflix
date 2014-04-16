require 'spec_helper'
require 'pry'

describe InvitationsController do
  describe 'POST #create' do
    context 'with a logged in user' do
      context 'with valid details' do
        let(:adam) { Fabricate(:user) }
        before do
          add_to_session(adam)
        end
        it 'creates a new inviation' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitee_details: friend
          expect(Invitation.count).to eq(1)
        end
        it 'sends an email to the invitee' do

        end
        it 'redirects to the same page'
        it 'shows a confirmation message'
      end
      context 'with invalid invitee details' do
        it 'redirects to the same page'
        it 'displays an error message to the user'
        it 'does not create an invitation'
      end
    end

    it_behaves_like "require_logged_in_user" do
      friend = Fabricate.attributes_for(:user)
      let(:action) { post :create, invitee_details: friend }
    end
  end
end
