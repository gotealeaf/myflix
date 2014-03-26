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

      it "assigns the requested video to @video" do
        expect(assigns(:video)).to eq(@back_to_the_future)
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
        @futurama = Video.create(title: "Futurama", description: "An pizza delievery boy gets frozen.")
        @back_to_the_future = Video.create(title: "Back to the Future", description: "Back in time!")
        @the_simpsons = Video.create(title: "The Simpsons", description: "Yellow people.")
        @south_park = Video.create(title: "South Park", description: "Some kids cause trouble.")
        @king_of_the_hill = Video.create(title: "King of the Hill", description: "Some Texians.")
        @modern_family = Video.create(title: "Modern Family", description: "A very funny modern famiyl.")
        get :search, search_term: "futur"
      end

      it "populates the @results array with videos matching the requested title" do
        expect(assigns(:results)).to match_array([@futurama, @back_to_the_future])
      end
      it "renders the search template" do
        expect(response).to render_template(:search)
      end
    end
  end
end