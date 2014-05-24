require "spec_helper"

describe UsersController do
  describe "GET new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User) 
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end
      
      it "saves new user to the database" do
        expect(User.count).to eq(1)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "assigns @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "sets notice" do
        expect(flash[:notice]).to_not be_blank
      end

      it "puts the user in the session" do
        expect(session[:user_id]).to eq(User.first.id)
      end
    end

    context "without valid input" do
      before do
        post :create, user: { fullname: nil, email: nil, password: nil }
      end

      it "does not save new user to the database" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template  :new
      end
    end  
  end
end