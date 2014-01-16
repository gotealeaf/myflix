require 'spec_helper'


describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
     user = Fabricate(:user)
     get :new
     assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
      
   end
  end

  
    # it "invalid entry should render new" do
    #   user = Fabricate(:user, email: nil)
    #   post :create
    #   expect(response).to redirect_to :new
    # end
  describe "POST create" do
     
    context "with valid input" do
       # post :create, user: {full_name: "Bob", email: 'bob@bob.bob', password: 'password'}
     before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      
      it "creates a user " do
        expect(User.count).to eq(1)
      end
    
      it "should redirect to sign in page" do
        expect(response).to redirect_to sign_in_path 
      end

    end

    context "with invalid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user, email: nil)
      end
      it "doesn't create a new user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets the @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

    end
  end
end  