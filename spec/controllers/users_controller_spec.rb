require 'spec_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if the user is inauthenticated" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET index" do
    it "shows all of the current user's followed users" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      get :index
      expect(alice.followed_users).to eq([bob])
    end
  end

  describe "GET show" do
    it "shows the user's queued videos" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: south_park, user: alice)

      get :show, id: alice.id
      expect(alice.queue_items).to eq([queue_item])
    end
    it "shows the user's reviews" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      review =  Fabricate(:review, rating: 3, user: alice, video: south_park )

      get :show, id: alice.id
      expect(alice.reviews).to eq([review])
    end
  end

  describe "POST create" do
    context "with valid input" do
      
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the videos path" do
        expect(response).to redirect_to videos_path
      end
    end
    context "with invalid input" do

      before do
        post :create, user: { full_name: "jane" }
      end

      it "does not create a record when input is invalid " do
        expect(User.count).to eq(0)
      end

      it "renders new template when input is invalid" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end

