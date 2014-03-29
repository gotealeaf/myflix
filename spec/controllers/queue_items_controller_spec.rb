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
      context "the video is not in the queue" do
        before do
          user = Fabricate :user
          session[:user_id] = user.id
          video = Fabricate :video
          post :add_to_queue, id: video.id
        end

        it "updates user queue_items adding the video" do
          expect(QueueItem.count).to eq(1)
        end

        it "redirects to my_queue page" do
          expect(response).to redirect_to video_path     
        end

        it "sets the notice" do 
          expect(flash[:notice]).to eq("The video has been added to your queue.")          
        end
      end

      context "the video is allready in the queue" do
        let(:user){ Fabricate :user }        
        before do
          session[:user_id] = user.id
          video = Fabricate :video
          queue_item = Fabricate(:queue_item, user: user, video: video)
          post :add_to_queue, id: video.id
        end

        it "does not update the queue" do
          expect(user.queue_items.count).to eq(1)
        end

        it "renders video when the video is allready in the queue" do
          expect(response).to render_template 'videos/show'
        end

        it "sets the error" do 
          expect(flash[:error]).to eq("The video is allready in your queue.")          
        end
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