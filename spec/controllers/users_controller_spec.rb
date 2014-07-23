require 'spec_helper'

describe UsersController do

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    it "assigns @user" do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "render template :show" do
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
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
          post :create, user: Fabricate.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it "redirect to root path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context "invalid attributes" do
      before { Fabricate(:user, email:"example@example.com") }

      it "dont create a new user record" do
        expect {
          post :create, user: Fabricate.attributes_for(:user, email: "example@example.com")
        }.not_to change(User, :count)
      end

      before {post :create, user: Fabricate.attributes_for(:user, email: "example@example.com")}

      it "render template :new" do
        expect(response).to render_template :new
      end

      it "assigns @user" do
        expect(assigns(:user)).to be_new_record
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET edit" do
    
  end

  describe "PUT update" do
    before do
      @user = Fabricate.create(:user, email: "Lawrence@example.com", full_name:"KK Smith")
    end

    context "valid attributes" do
      it "locate requested @user" do
        put :edit, id: @user
        expect(assigns(:user)).to eq(@user)
      end

      it "change @user' attributes" do
        put :update, id: @user.id, user: Fabricate.attributes_for(:user, email: "marisa@becker.com", full_name: "Brianne Mraz")
        @user.reload

        expect(@user.email).to eq("marisa@becker.com")
      end
    end

  end
end
