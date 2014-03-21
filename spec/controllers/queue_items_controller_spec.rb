require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe "GET index" do
    context "when user is authenticated" do
      it "sets the @queue_items variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        queue1 = Fabricate(:queue_item, user: current_user)
        queue2 = Fabricate(:queue_item, user: current_user)

        get :index
        expect(assigns(:queue_items)).to match_array([queue1, queue2])
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

      post :create
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
      que2 = Fabricate(:queue_item, video_id: family_guy.id, user_id: current_user.id)
      que1 = Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id)

      expect(current_user.queue_items.all).to match_array([que2, que1])
    end

    it "does not add the video to the que if the video is already in the que" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      south_park = Fabricate(:video)
      family_guy = Fabricate(:video)
      queue1 = Fabricate(:queue_item, video: south_park, user: current_user)
      queue2 = Fabricate(:queue_item, video: family_guy, user: current_user)
      
      post :create, queue_item: { video: south_park, user: current_user }, video_id: south_park.id, user_id: current_user.id
      expect(current_user.queue_items.count).to eq(2)
    end

    it "redirects to the sign in page for unauthenticated users" do
      current_user = Fabricate(:user)
      south_park = Fabricate(:video)
      
      post :create, queue_item: { video_id: south_park.id, user_id: current_user.id }, video_id: south_park.id, user_id: current_user.id
      expect(response).to redirect_to(sign_in_path)
    end
  end

=begin
  describe "POST destroy" do
    it "removes a queue item from the current user's que page" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      family_guy = Fabricate(:video)
      south_park = Fabricate(:video)
      q1 = Fabricate(:queue_item, video: family_guy, user: current_user)
      q2 = Fabricate(:queue_item, video: south_park, user: current_user)

      delete :destroy, queue_item: { queue_item: q1 }, queue_item_id: q1.id
      expect(current_user.queue_items).to eq(1)
    end
  end
=end

  describe "POST sort" do
    context "with valid inputs"
      it "redirects to the queue items page" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        
        post :sort
        expect(response).to redirect_to(queue_items_path)
      end

      it "re orders each item numerically" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        family_guy = Fabricate(:video)
        south_park = Fabricate(:video)
        simpsons = Fabricate(:video)
        q1 = Fabricate(:queue_item, video: family_guy, user: current_user, position: 1)
        q2 = Fabricate(:queue_item, video: south_park, user: current_user, position: 2)
        q3 = Fabricate(:queue_item, video: simpsons, user: current_user, position: 3)
        
        post :sort, queue_items: {id: q1.id, position: 2}
        expect(q1.position).to eq(2)
      end
      it "normalizes the position numbers" do
      end
    context "with invalid inputs"
    context "with unauthenticated user"
  end
  
end