require 'spec_helper'

describe UsersController do
  Sidekiq::Testing.fake! do
    describe "Sidekiq" do
      before { post :create, params }
      after  do
        Sidekiq::Worker.clear_all
      end

      it "successfully sends to Sidekiq's queue" do
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq(1)
      end
    end
  end

  describe 'Registration' do

    describe "GET new" do
      it "makes a new instance" do
        get :new
        expect(assigns(:user)).to be_a_new User
      end
    end

    describe "GET new_with_token" do

      context "with valid token" do
        let(:joe) { Fabricate(:user) }
        let(:invite) { Fabricate(:invitation, inviter_id: joe.id) }
        before { get :new_with_token, token: invite.token }

        it "renders the 'new' view template" do
          expect(response).to render_template 'new'
        end
        it "makes a new instance of a user" do
          expect(assigns(:user)).to be_a_new User
        end
        it "populates the @invitation with the invite info to this user" do
          expect(assigns(:invitation)).to be_a Invitation
        end
        it "gets the invited guest's email from the token" do
          expect(assigns(:invitation).friend_email).to eq(invite.friend_email)
        end
      end

      context "with invalid token do" do
        before { get :new_with_token, token: "expired_token" }

        it "redirects to the expired token page for expired tokens" do
          expect(response).to redirect_to expired_token_path
        end
      end
    end

    describe "POST create" do
      context "with valid info" do
        let(:joe) { Fabricate.build(:user) }
        let(:params) { {user: { name: joe.name, email: joe.email, password: joe.password }} }

        it "makes a new user" do
          expect do
            post :create, params
          end.to change(User, :count).by(1)
        end
        it "signs in user" do
          post :create, params
          expect(session[:user_id]).to eq(User.find_by(email: joe.email).id)
        end

        context "email sending" do
          before { post :create, params }
          after  do
            ActionMailer::Base.deliveries.clear
            Sidekiq::Worker.clear_all
          end

          it "sends an email upon successful creation" do
            ActionMailer::Base.deliveries.should_not be_empty
          end
          it "sends email to the registering user's email address" do
            email = ActionMailer::Base.deliveries.last
            email.to.should eq([joe.email])
          end
          it "has a welcome message in the subject" do
            email = ActionMailer::Base.deliveries.last
            email.subject.should include("Welcome to MyFLiX")
          end
          it "has a welcome message in the body" do
            email = ActionMailer::Base.deliveries.last
            expect(email.parts.first.body.raw_source).to include(joe.name)
          end
          it "successfully sends to Sidekiq's queue" do
            expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq(1)
          end
        end
      end

      context "with valid info AND invitation token, adds the following" do
        let(:jen)    { Fabricate(:user) }
        let(:invite) { Fabricate(:invitation, inviter_id: jen.id) }
        let(:joe)    { Fabricate.build(:user) }
        let(:params) { {user: { name: joe.name, email: joe.email, password: joe.password },
                        token: invite.token} }
        before { post :create, params }
        after  { ActionMailer::Base.deliveries.clear }

        it "loads the token into @token instance variable" do
          expect(assigns(:token)).to eq(invite.token)
        end
        it "loads user input into into @user instance variable" do
          #ODD - it's assigning to the final state, not to the initial state in the test....
          expect(assigns(:user)).to eq(User.last)
        end

        context "after saving the valid user" do
          it "loads the invitation variable" do
            expect(assigns(:invitation)).to eq(invite)
          end
          it "loads the inviter from the invitation" do
            expect(assigns(:inviter)).to eq(jen)
          end
          it "sets the inviter as following the friend" do
            joe = User.last
            expect(jen.leaders).to include(joe)
          end
          it "sets the inviter as following the friend" do
            joe = User.last
            expect(joe.leaders).to include(jen)
          end
          it "sets the invitation token to nil - thus invalidating it from use" do
            expect(invite.reload.token).to be_nil
          end
        end
      end

      context "with INVALID information" do
        let(:params) { {user: { name: "", email: "", password: "" }} }
        after  { ActionMailer::Base.deliveries.clear }

        it "does not create a new user" do
          expect {post :create, params
            }.to_not change(User, :count)
        end
        it "populates a new instance" do
          post :create, params
          expect(assigns(:user)).to be_instance_of User
        end
        it "records errors on the variable" do
          post :create, params
          expect(assigns(:user).errors.size).to be > 0
        end
        it "renders the new view template" do
          post :create, params
          expect(response).to render_template :new
        end
        it "does not send an email" do
          post :create, params
          ActionMailer::Base.deliveries.should be_empty
        end
      end
    end
  end

  describe "GET show" do
    let!(:joe) { Fabricate(:user) }

    it "should set the @user with user for profile page" do
      sign_in_user
      get :show, id: joe.id
      expect(assigns(:user)).to eq(joe)
    end

    context "should should redirect unauthenticated/guest (not signed-in) users" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { get :show, id: joe.id }
      end
    end
  end


  describe "set_user" do
    let!(:joe) { Fabricate(:user) }

    it "should det the @user with user for profile page" do
      get :show, id: joe.id
      expect(@controller.instance_eval{set_user}).to eq(joe)
    end
  end
end


