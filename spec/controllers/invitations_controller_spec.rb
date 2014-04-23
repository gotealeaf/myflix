require 'spec_helper'
require 'pry'

describe InvitationsController do
  describe 'POST #create' do
    context 'with a logged in user' do
      before do
        add_to_session(adam)
      end
      context 'with valid details' do
        let(:adam) { Fabricate(:user) }
        it 'creates a new inviation' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitation: friend
          expect(Invitation.count).to eq(1)
        end
        it 'generates a invite token for that invite' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitation: friend
          expect(Invitation.first.invite_token).to_not be_nil
        end
        it 'sends an email to the invitee' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitation: friend
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([friend[:email]])
        end
        it 'redirects to the same page' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitation: friend
          expect(response).to redirect_to new_invitation_path
        end
        it 'shows a confirmation message' do
          friend = Fabricate.attributes_for(:user)
          post :create, invitation: friend
          expect(flash[:success]).to be_present
        end
        context 'email for invitation already in system' do
          it 'doesnt duplicate inviations' do
            friend = Fabricate.attributes_for(:user)
            post :create, invitation: friend
            post :create, invitation: friend
            expect(Invitation.count).to eq(1)
          end
          it 'doesnt create invite if email already in use for user' do
            friend = Fabricate.attributes_for(:user)
            User.create(friend)
            post :create, invitation: friend
            expect(Invitation.count).to eq(0)
          end
          it 'displays an error message to the user' do
            friend = Fabricate.attributes_for(:user)
            User.create(friend)
            post :create, invitation: friend
            expect(flash[:danger]).to be_present
          end
        end
        context 'with invalid invitee details' do
          it 'does not create an invitation' do
            post :create, invitation: {"email"=>"lyda.mraz@mills.com", "fullname"=> nil,
                                       "password"=>"rhett@runolfon.org"}
            expect(Invitation.count).to eq(0)
          end
          it 'displays an error message to the user' do
            post :create, invitation: {"email"=>"lyda.mraz@mills.com", "fullname"=> nil,
                                       "password"=>"rhett@runolfon.org"}
            expect(flash[:danger]).to be_present
          end
        end
      end
    end
    it_behaves_like "require_logged_in_user" do
      friend = Fabricate.attributes_for(:user)
      let(:action) { post :create, invitation: friend }
    end
  end
end
