require 'spec_helper'

describe UsersController do
  describe "GET show" do
    let(:user) { FactoryGirl.create(:user) }
    it "assigns @user" do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it "render template :show" do
      get :show, id: user.id
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_new_record
    end

    it "render template :new" do
      get :new
      expect(response).to render_template :new
    end
  end


  describe "POST create" do
    context "valid attributes" do
      it "create a new user record" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it "redirect to root path" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context "invalid attributes" do
      it "dont create a new user record" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.not_to change(User, :count)
      end

      it "render template :new" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do

  end

  describe "PUT update" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context "valid attributes" do
      before :each do
        put :update,{ id: @user, user: FactoryGirl.attributes_for(:user, email: "example@example.com", full_name: "user") }
        @user.reload
      end

      it { expect(@user.email).to eq("example@example.com") }
      it { expect(@user.full_name).to  eq("user")}
    end

  end
end
