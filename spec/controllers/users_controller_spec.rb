require 'spec_helper'

describe UsersController do

  let(:hank)  { Fabricate(:user) }

#######################################################
  describe 'forgot_password' do
    it_behaves_like "does_not_require_sign_in" do
      let(:action) {get :forgot_password}
    end
  end
#######################################################

  describe 'reset_password' do
    it_behaves_like "does_not_require_sign_in" do
      let(:action) {get :reset_password}
    end
  end
#######################################################
  describe 'confirm password reset' do

    it_behaves_like "does_not_require_sign_in" do
      let(:action) {post :confirm_password_reset, email: "r@example.com"}
    end

    it "sends a password reset email when the email is valid" do
      post :confirm_password_reset, email: hank.email
      expect(ActionMailer::Base.deliveries).to_not be_empty
      ActionMailer::Base.deliveries.clear
    end

    it "does NOT send a password reset email when the email is INvalid" do
      post :confirm_password_reset, email: "r@fake.com"
      expect(ActionMailer::Base.deliveries).to be_empty
      ActionMailer::Base.deliveries.clear
    end
  end
  

#######################################################

  describe 'GET show' do
    it_behaves_like "require_sign_in" do
      let(:action) {get :show, id: 1}
    end

    it "prepares the user instance variable" do
      set_current_user(hank)
      get :show, id: hank.id
      expect(assigns(:user)).to eq(hank)
      end
  end
#######################################################
  describe 'GET new' do
        it "generates a new record" do
          get :new
          assigns(:user).should be_instance_of(User)
        end
  end

  context "the user sign up is valid" do
 
    before do
      post :create, user: Fabricate.attributes_for(:user)
    end

    after do
      #unlike the test database, RSpec does not automatically clear the mail queue
      ActionMailer::Base.deliveries.clear
    end


      describe 'POST create' do
        it "generates a user from valid data" do
          User.count.should == 1
        end

        it "redirects to sign_in" do
          response.should redirect_to sign_in_path
        end

        it "sends a welcome email " do
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end
        
        it "checks if the email is addressed to the right person" do
          expect(ActionMailer::Base.deliveries.last.to).to eq(["rick.heller@yahoo.com"])
        end

        it "has the correct content" do
          expect(ActionMailer::Base.deliveries.last.body).to include("Welcome")
        end

      end

  end



  context "the user sign up is INVALID" do

    before do
      post :create, user: {email: "", password: "", full_name: ""}
    end

    describe 'POST create' do
        it "does NOT generate a user from INvalid data" do
          User.count.should == 0
        end

        it "renders redirect to sign_in" do
          response.should render_template :new
        end

        it "DOES NOT send a welcome email " do
          expect(ActionMailer::Base.deliveries).to be_empty
        end

        it "regenerates a user record for another try" do
          assigns(:user).should be_instance_of(User)
        end


    end
  end

end
