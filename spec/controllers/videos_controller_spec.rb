require 'spec_helper'


describe VideosController do
  describe "GET index" do
    it "sets the @categories variable with authenticated users" do
      session[:user_id] = Fabricate(:user).id

      cat1 = Category.create(name: "80's")
      cat2 = Category.create(name: "90's")

      get :index
      assigns(:categories).should == [cat1, cat2]
    end

    it "renders the index template with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      
      get :index
      response.should render_template :index
    end

    it "redirect the user to sign_in page with unauthenticated users" do
      cat1 = Category.create(name: "80's")
      cat2 = Category.create(name: "90's")
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET show" do
    it "sets @video with authenticated users" do
      session[:user_id] = Fabricate(:user).id

      video = Fabricate :video
      get :show, id: video.id
      expect(assigns :video).to eq video
    end

    it "renders the show template with authenticated users" do
      session[:user_id] = Fabricate(:user).id

      video = Fabricate :video
      get :show, id: video.id
      response.should render_template :show
    end

    it "redirect the user to sign_in page with unauthenticated users" do
      video = Fabricate :video
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets the @video with unauthenticated users" do
      session[:user_id] = Fabricate(:user).id

      video = Fabricate :video, title: "Paquito Jimenez"
      post :search, title: "Paquito"
      expect(assigns :videos).to eq([video])
    end

    it "redirects to sign_in page with unauthenticated users" do
      video = Fabricate :video, title: "Paquito Jimenez"
      post :search, title: "Paquito"
      expect(response).to redirect_to sign_in_path
    end
  end 
end
