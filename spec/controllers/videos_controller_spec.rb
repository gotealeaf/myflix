require 'spec_helper'
require 'pry'

describe VideosController do
  let(:smaug) { User.create(email: "smaug@lonelymountain.com", full_name: "Smaug the Magnificent", password: "gold", password_confirmation: "gold") }
  let(:video_1) { Fabricate(:video) }

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
        get :show, id: video_1.id
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "a user is signed in" do
      before :each do
        session[:user_id] = smaug.id
        get :show, id: video_1.id
      end

      it "assigns the requested video to @video" do
        expect(assigns(:video)).to eq(video_1)
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "GET search" do
    context "no user is signed in" do
      it "redirects to the sign_in_path" do
        get :search
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "a user is signed in" do
      before :each do
        session[:user_id] = smaug.id
        Fabricate(:video)
        Fabricate(:video)
        Fabricate(:video)
        get :search, search_term: "future"
      end

      it "populates the @results array with videos matching the requested title" do
        expect(assigns(:results)).to have(3).items
      end
      it "renders the search template" do
        expect(response).to render_template(:search)
      end
    end
  end
end