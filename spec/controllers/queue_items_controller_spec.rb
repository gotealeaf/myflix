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

        let(:user){ Fabricate :user }    
        let(:video){ Fabricate :video }     

        before do
          session[:user_id] = user.id
          post :add_to_queue, id: video.id
        end

        it "updates user queue_items adding the video" do
          expect(user.queue_items.count).to eq(1)
        end

        # it "sets queue_item the last one by order" do
        #   video2 = Fabricate :video
        #   queue_item = Fabricate(:queue_item, user: user, video: video2, order: 88)
        #   order = user.queue_items.last.order

        #   expect(user.queue_items[1].order).to eq(order)
        # end

        it "sets queue_item = 1 when is the first video added to the queue" do
          expect(user.queue_items.last.order).to eq(1)
        end

        it "redirects to my_queue page when the video has been added to the queue" do
          expect(response).to redirect_to video_path     
        end

        it "sets the notice when the video has been added to the queue" do 
          expect(flash[:notice]).to eq("The video has been added to your queue.")          
        end
      end


        it "sets queue_item the last one by order for a video that is not in the queue" do
          user = Fabricate :user
          video = Fabricate :video
          session[:user_id] = user.id
          video1 = Fabricate :video
          video2 = Fabricate :video
          video3 = Fabricate :video

          queue_item = Fabricate(:queue_item, user: user, video: video1, order: 2)
          queue_item = Fabricate(:queue_item, user: user, video: video2, order: 3)
          queue_item = Fabricate(:queue_item, user: user, video: video3, order: 4)
          order = user.queue_items.last.order

          post :add_to_queue, id: video.id
          expect(user.queue_items.last.order).to eq(order + 1)
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

        it "renders videos/show template when the video is allready in the queue" do
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