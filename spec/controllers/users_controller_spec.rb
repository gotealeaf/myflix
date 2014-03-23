require 'spec_helper'

describe UsersController do
  describe "GET 'new'" do
    before do
      get 'new'
    end

    it "returns http success" do
      response.should be_success
    end

    it "sets the @user" do
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST 'create'" do

    context "with duplicated email" do
    end

    context "with invalid input" do
      let(:user) { Fabricate(:user) }

      before do
        post "create", user: {
          email: user.email,
          password:  Faker::Internet.password,
          full_name: Faker.name
        }
      end

      it "renders 'new' template" do
        response.should render_template(:new)
      end

      it "does not create user" do
        User.count.should == 1
        User.first.should == user
      end
    end

    context "missing attribute" do
      let(:user) { Fabricate.build(:user) }

      before do
        post "create", user: {
          # email is missing
          password:  Faker::Internet.password,
          full_name: Faker.name
        }
      end

      it "renders 'new' template" do
        response.should render_template(:new)
      end

      it "does not create user" do
        User.count.should be_zero
      end
    end

    context "with valid input" do
      let(:user) { Fabricate.build(:user) }

      def post_user
        post "create", user: {
          email:     user.email,
          password:  user.password,
          full_name: user.full_name
        }
      end

      it "creates a user" do
        expect { post_user }.to change{ User.count }.by(1)
      end

      it "redirect to sign in page" do
        post_user
        response.should redirect_to(sign_in_path)
      end
    end
  end
end
