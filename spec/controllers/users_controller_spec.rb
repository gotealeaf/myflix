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

    context "sending email" do

      after { ActionMailer::Base.deliveries.clear }
      
      it "send email to user with valid inputs" do
        post :create, user:{ email: "joe@example.com", password: "password", full_name: "Joe Johnson"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
      it "send email contaning the users name" do
        post :create, user:{ email: "joe@example.com", password: "password", full_name: "Joe Johnson"}
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Johnson")
      
      end

      it "does not send email with invalid inputs" do
        post :create, user:{ email: "joe@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
        
      end

    end #context sending email
  end #end POST create

  describe "GET #show" do

    context "with authenticated users" do
      it_behaves_like "require_sign_in" do
        let(:action) {get :show, id: 3}  #id: is not necessary.  This calls the shared example.
      end
      it "sets @user" do
       set_current_user
       alice = Fabricate(:user)
        get :show, id: alice.id
        expect(assigns(:user)).to eq(alice)


      end

      
    end

  end

end
