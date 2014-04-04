require 'spec_helper'

describe UsersController do

  describe 'Registration' do

    describe "GET new" do
      it "should make a new instance" do
        get :new
        expect(assigns(:user)).to be_a_new User
      end
    end

    describe "POST create" do
      context "with valid info" do
        let(:params) { {user: { name: "Joe", email: "email@email.com", password: "password" }} }

        it "makes a new user" do
          expect do
            post :create, params
          end.to change(User, :count).by(1)
        end
        it "signs in user" do
          post :create, params
          expect(session[:user_id]).to eq(User.find_by(email: "email@email.com").id)
        end
      end

      context "with INVALID information" do
        let(:params) { {user: { name: "", email: "", password: "" }} }

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
      end
    end
  end
end
