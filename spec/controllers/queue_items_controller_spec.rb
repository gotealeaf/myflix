require "spec_helper"

describe QueueItemsController do
  context "authenticated user" do  
    describe "GET index" do
      it "sets @my_queue variable" do 
        user = Fabricate :user
        session[:user_id] = user.id

        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        queue_item3 = Fabricate(:queue_item, user: user)

        get :index

        expect(assigns :queue_items).to match_array([queue_item1, queue_item2, queue_item3])
      end
    end

    describe "POST add_to_queue" do
      it "redirects to my_queue page" do
        user = Fabricate :user
        session[:user_id] = user.id
        video = Fabricate :video

        post :add_to_queue, id: video.id

        expect(response).to redirect_to "video/show"      
      end

      it "updates user queue_items adding the video" do
        user = Fabricate :user
        session[:user_id] = user.id
        video = Fabricate :video
        # queue_item = Fabricate(:queue_item, user: user, video: video, rating: nil)

        post :add_to_queue, id: video.id

        expect(QueueItem.last.user).to eq(user)
        expect(QueueItem.last.video).to eq(video)
      end
    end

    describe "POST update" do
      it "updates the order" do
      end

      it "updates videos rating" do
      end

      it "redirects to my-queue page" do 
      end
    end

    describe "GET delete" do
      it "removes the video from the queue" do
      end

      it "renders my-queue template" do
      end
    end
  end

  context "unauthenticated user" do 
    describe "GET index" do
      it "redirects to sign_in page" do 
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "POST add_to_queue" do
      it "redirects to sign_in page" do 
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end