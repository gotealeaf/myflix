require 'spec_helper'

describe UsersController do

  describe "GET #new" do
    it "instantiates a new user object" do
      
      get :new

      expect(assigns(:user)).to be_an_instance_of(User) 

    end
    it "renders the sign-in form" do

      user = User.new
      get :new, id: user.id

      expect(response).to render_template :new

    end
  end #end #new

  describe "POST #create" do

    context "with valid input" do
      before { post :create,  user: Fabricate.attributes_for(:user) }
      it "creates and saves a new user" do
               
        expect(User.count).to eq(1)

      end
      
      it "redirects to the home page of the new user" do
        

        expect(response).to redirect_to home_path

      end
    end #end context valid
    
    context "with invalid input" do
      before {post :create,  user: {full_name: "exe", password: "password"}}

      it "should not create a user" do
        expect(User.count).to eq(0)
      end
      
      it "re-renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_an_instance_of(User) 
      end

    end #end context invalid
  end

end
