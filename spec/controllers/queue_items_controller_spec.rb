require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe "GET index" do
    context "when user is authenticated" do
      it "sets the @queue_items variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        queue1 = Fabricate(:queue_item)
        queue2 = Fabricate(:queue_item)

        get :index
        expect(assigns(:queue_items)).to match_array([queue2, queue1])
      end

      it "sets the @video variable"
    end
    context "when user is inauthenticated" do
      it "redirects the user to the sign page" do
        curent_user = Fabricate(:user)
    
        queue1 = Fabricate(:queue_item)
        queue2 = Fabricate(:queue_item)

        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST create" do
    it "redirects to the my que page" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create#, queue_item: {video: video, user: current_user}, video_id: video.id
      expect(response).to redirect_to(queue_items_path)
    end

    it "creates a que item" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create
      expect(QueueItem.count).to eq(1)
    end

    it "creates the que item that is associated with the video" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create, queue_item: { video_id: video.id }, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the que item that is associated with the signed in user" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create, queue_item: { video_id: video.id, user_id: current_user.id }, video_id: video.id, user_id: current_user
      expect(QueueItem.first.user).to eq(current_user)
    end

    it "puts the video as the last one in the que" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      south_park = Fabricate(:video)
      family_guy = Fabricate(:video)
      que1 = Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id)
      que2 = Fabricate(:queue_item, video_id: family_guy.id, user_id: current_user.id)

      expect(QueueItem.all).to match_array([que1, que2])
    end

    it "does not add the video to the que if the video is already in the que" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      south_park = Fabricate(:video)
      queue1 = Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id)
      
      post :create, queue_item: { video_id: south_park.id, user_id: current_user.id }, video_id: south_park.id, user_id: current_user.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to the sign in page for unauthenticated users" do
      current_user = Fabricate(:user)
      south_park = Fabricate(:video)
      
      post :create, queue_item: { video_id: south_park.id, user_id: current_user.id }, video_id: south_park.id, user_id: current_user.id
      expect(response).to redirect_to(sign_in_path)
    end

  end
  
end