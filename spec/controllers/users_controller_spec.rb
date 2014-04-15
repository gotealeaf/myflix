require 'spec_helper'

describe UsersController do
  after { ActionMailer::Base.deliveries.clear }
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      context "sends email" do
        it "sends an email" do
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end

        it "emails to the correct user" do
          email = ActionMailer::Base.deliveries.last
          expect(email.to).to eq([User.last.email])
        end

        it "email contains proper content" do
          email = ActionMailer::Base.deliveries.last
          expect(email.body).to include("#{User.last.full_name}")
        end
      end
    end

    context "with invalid input" do
      
      before do
        post :create, user: { email: "aleksey@example.com", password: 'password', password_confirmation: 'bad password', full_name: "Aleksey Chaikovsky" }
      end

      it "does not create the user" do        
        expect(User.count).to eq(0)
      end

      it "render the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "does not send welcome email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET show" do
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: 2 }
    end

    it "sets @user" do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end
end