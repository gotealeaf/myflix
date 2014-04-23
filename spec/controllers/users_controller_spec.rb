require 'spec_helper'
require 'pry'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe UsersController do
  describe 'GET #show' do
    context 'authenticated users' do
      let(:adam) { Fabricate(:user) }
      before do
        add_to_session(adam)
        Fabricate(:review, user: adam)
        Fabricate(:review, user: adam)
        Fabricate(:queue_item, user: adam)
        Fabricate(:queue_item, user: adam)
      end

      it 'sets up the user in the controller' do
        get :show, id: adam.id
        expect(assigns(:user)).to eq(adam)
      end
    end
    context "unauthenticated users" do
      let(:adam) { Fabricate(:user) }
      it_behaves_like "require_logged_in_user" do
        user = Fabricate(:user)
        let(:action) { get :show, id: user.id }
      end
    end
  end

  describe 'GET #new' do
    it 'sets up new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'redirects the user if they are logged in already' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
    context 'with an invite token' do
      context 'with valid invite token' do
        it 'matches an invite by the invite token' do
          invitation = Fabricate(:invitation)
          get :new, invite_token: invitation.invite_token
          expect(assigns(:user).email).to eq(invitation.email)
        end
      end

      context 'with token with status other than pending' do
        it 'does not let the invitation be used if the status is not pending' do
          invitation = Fabricate(:invitation, status: "accepted")
          get :new, invite_token: invitation.invite_token
          expect(assigns(:user).email).to eq(nil)
        end
        it 'displays a warning if the invite is not valid' do
          invitation = Fabricate(:invitation, status: "accepted")
          get :new, invite_token: invitation.invite_token
          expect(flash[:danger]).to be_present
        end
      end

      context 'with invalid invite token' do
        it 'displays an error message to the user' do
          Fabricate(:invitation)
          get :new, invite_token: SecureRandom.urlsafe_base64
          expect(flash[:danger]).to be_present
        end
        it 'redirects the user back to the register path' do
          Fabricate(:invitation)
          get :new, invite_token: SecureRandom.urlsafe_base64
          expect(response).to redirect_to register_path
        end
      end
    end
  end

  describe "POST #create" do
    context 'with valid input' do
      before do
        @user_sample_params = Fabricate.attributes_for(:user)
        post :create, user: @user_sample_params
      end

      it 'sets up the @user with the user_params' do
        user = User.find_by(email: @user_sample_params[:email])
        expect(user.authenticate(@user_sample_params[:password])).to be_instance_of(User)
      end

      context 'sends confirmation email correctly' do
        it 'checks there was an email sent' do
          message = ActionMailer::Base.deliveries.last
          expect(message).to_not be_blank
        end
        it 'checks the email is being sent to the correct person' do
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([User.first.email])
        end
        it 'checks the email body is correct' do
          message = ActionMailer::Base.deliveries.last
          expect(message.subject).to include("Thank you for signing up for MyFlix")
        end
      end

      it 'sets the session[user_id] if sucessfully saved' do
        adam = User.first
        add_to_session(adam)
        expect(session[:user_id]).to eq(adam.id)
      end

      it 'redirects the user if the save was sucessful' do
        expect(response).to redirect_to home_path
      end

      it 'sets the flash[:success]' do
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid input' do
      before do
        post :create, user: Fabricate.attributes_for(:user, fullname: nil)
      end

      it 'it fails to save if params incorrect' do
        DatabaseCleaner.clean
        expect(User.count).to eq(0)
      end

      it 'renders #new if the save was not successful' do
        expect(response).to render_template :new
      end
    end
  end
  context 'the user has a valid reset token' do
    it 'creates a followship between invitee and inviter' do
      invitation = Fabricate(:invitation)
      post :create, user: { email: invitation.email, fullname: invitation.fullname, password: "testing123" }, invite_token: invitation.invite_token
      expect(User.first.followers.count).to eq(1)
      expect(User.last.followers.count).to eq(1)
    end
    it 'updates the status the invitation to accepted' do
      invitation = Fabricate(:invitation)
      post :create, user: { email: invitation.email, fullname: invitation.fullname, password: "testing123" }, invite_token: invitation.invite_token
      expect(Invitation.first.status).to eq("accepted")
    end
  end
end
