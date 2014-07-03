require "rails_helper"
 
describe UsersController do  
  describe "GET new" do
    it "sets @user as a new User" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end # GET new

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid input" do
      before { post :create, user: { password: "password", name: "Cullen Jett" } }
      
      it "does not create a user" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_a(User)
      end
    end

    context "sending emails" do
      after { ActionMailer::Base.deliveries.clear }
      
      it "sends email to new users with vaild inputs" do
        post :create, user: { email: "joe@example.com", password: "password", name: "Joe" }

        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
      
      it "sends email containing the user's name with valid inputs" do
        post :create, user: { email: "joe@example.com", password: "password", name: "Joe" }

        expect(ActionMailer::Base.deliveries.last.body).to include("Joe")
      end

      it "does not send email with invalid inputs" do
        post :create, user: { email: "joe@example.com" }

        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end # POST create

  describe "GET show" do
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      
      get :show, id: alice.id

      expect(assigns(:user)).to eq(alice)
    end
  end #GET show
end