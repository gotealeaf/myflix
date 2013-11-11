require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "assign the requested video to @video if the user is authorized" do
      user = User.create(email: "dennysantoso.com@gmail.com", full_name: "Denny Santoso", password: "admin", password_confirmation: "admin")
      session[:user_id] = user.id
      video1 = Video.create(title: 'video1', description: 'video1 description')
      get :show, id: video1.id
      expect(assigns(:video)).to eq(video1)
    end

    it "should redirect user to front page if user is not signed in" do
      session[:user_id] = nil
      video1 = Video.create(title: 'video1', description: 'video1 description')
      get :show, id: video1.id
      expect(response).to redirect_to sign_in_path
    end

    it "renders the show video page if the user is authorized" do
      user = User.create(email: "dennysantoso.com@gmail.com", full_name: "Denny Santoso", password: "admin", password_confirmation: "admin")
      session[:user_id] = user.id
      video1 = Video.create(title: 'video1', description: 'video1 description')
      get :show, id: video1.id
      expect(response).to render_template :show
    end
  end
end