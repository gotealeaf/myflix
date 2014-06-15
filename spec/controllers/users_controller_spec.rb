require 'rails_helper.rb'

describe UsersController do
  let(:user) { Fabricate(:user) }

  describe "GET new" do
    it "sets new @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input data" do
      it "creates the user" do
        post :create, user: { email: "#{user.email}", password: "#{user.password}", full_name: "#{user.full_name}"}
        expect(User.count).to eq(1)
      end

      # IMPORTANT: why does this manual data work, but fabricator data above does not?
      it "redirects to videos_path" do
        post :create, user: { email: "joshleeman@gmail.com", password: "password", full_name: "Josh Leeman" }
        expect(response).to redirect_to videos_path
      end
    end

    context "with invalid input data" do
      it "does not create the user" do
        post :create, user: { password: "password", full_name: "Josh Leeman}"}
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        post :create, user: { password: "password", full_name: "Josh Leeman}"}
        expect(response).to render_template :new
      end

      it "sets new @user" do
        post :create, user: { password: "password", full_name: "Josh Leeman}"}
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
