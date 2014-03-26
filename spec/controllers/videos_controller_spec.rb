require 'spec_helper'
require 'pry'

describe VideosController do
  let(:smaug) { User.create(email: "smaug@lonelymountain.com", full_name: "Smaug the Magnificent", password: "gold", password_confirmation: "gold") }

  describe "GET index" do
    context "no user is signed in" do
      it "redirects to the sign_in_path" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "a user is signed in" do
      it "renders the index template if a user is logged in" do
        session[:user_id] = smaug.id
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET show" do
    context "no user is signed in" do
      it "redirects to the sign_in_path" do
        @back_to_the_future = Video.create(title: "Back to the future", description: "Back in time!")
        get :show, id: @back_to_the_future.id
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "a user is signed in" do
      before :each do
        session[:user_id] = smaug.id
        @back_to_the_future = Video.create(title: "Back to the future", description: "Back in time!")
        get :show, id: @back_to_the_future.id
      end

      it "sets the @video variable to the designated id" do
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end
    end
  end
end