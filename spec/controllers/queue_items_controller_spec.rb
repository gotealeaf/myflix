require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    let(:user) { Fabricate(:user) }

    it "redirects to sign_in_path with unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end

    context "with authenticated users" do
      before :each do
        session[:user_id] = user
        @queue_item_1 = Fabricate(:queue_item, user: user, position: 1)
        @queue_item_2 = Fabricate(:queue_item, user: user, position: 2)
        get :index
      end

      it "sets @queue_items" do
        expect(assigns(:queue_items)).to match_array([@queue_item_1, @queue_item_2])
      end

      it "renders queue template" do
        expect(response).to render_template 'users/my_queue'
      end
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "redirects to sign_in_path with unauthenticated users" do
      post :create
      expect(response).to redirect_to sign_in_path
    end


    context "video is not in user queue with authenticated users" do
      it "creates queue_item associated with video and user" do
        session[:user_id] = user
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq video
        expect(QueueItem.first.user).to eq user
      end

      it "assigns next available position to the queue_item" do
        session[:user_id] = user
        Fabricate(:queue_item, user: user)
        post :create, video_id: video.id
        expect(QueueItem.find_by(video: video).position).to eq 2
      end

      it "assigns the first position if there are no other queue_items for the user" do
        session[:user_id] = user
        post :create, video_id: video.id
        expect(QueueItem.first.position).to eq 1
      end

      it "redirects to my_queue path" do
        session[:user_id] = user
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
    end

    context "video is in user queue with authenticated users" do
      before :each do
        session[:user_id] = user
        Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
      end

      it "does not save the queue_item" do
        expect(QueueItem.count).to eq 1
      end

      it "sets warning message" do
        expect(flash[:warning]).to_not be_blank
      end

      it "redirects to video page" do
        expect(response).to redirect_to video
      end
    end
  end

  describe "DELETE destroy" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:queue_item) { Fabricate(:queue_item, video: video, user: user) }

    it "redirects to my queue" do
      session[:user_id] = user
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "removes the queue item from the db" do
      session[:user_id] = user
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq 0
    end

    it "does not delete queue item if not in the current user's queue" do
      session[:user_id] = Fabricate(:user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq 1
    end

    it "redirects to sign_in_path with unauthenticated users" do
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "PATCH update_queue" do
    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        patch :update_queue
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with valid input" do
      context "multiple passed parameters" do
        before :each do
          @user = Fabricate(:user)
          session[:user_id] = @user
          @queue_item_1 = Fabricate(:queue_item, user: @user, position: 1)
          @queue_item_2 = Fabricate(:queue_item, user: @user, position: 2)
        end

        it "redirects to my queue" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "2" },
                                   { "id" => @queue_item_2.id, "position" => "1" }]
          expect(response).to redirect_to my_queue_path
        end

        it "reorders the queue_items" do
          patch :update_queue, "queue_items" =>
                                 [{ "id" => @queue_item_1.id, "position" => "2" },
                                  { "id" => @queue_item_2.id, "position" => "1" }]
          expect(@queue_item_1.reload.position).to eq 2
          expect(@queue_item_2.reload.position).to eq 1
        end

        it "does not update other user's queue items" do
          user_2 = Fabricate(:user)
          queue_item_3 = Fabricate(:queue_item, user: user_2, position: 1)
          queue_item_4 = Fabricate(:queue_item, user: user_2, position: 2)
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "2" },
                                   { "id" => @queue_item_2.id, "position" => "1" }]
          expect(queue_item_3.reload.position).to eq 1
          expect(queue_item_4.reload.position).to eq 2  
        end
      end

      context "single parameter for last position" do
        before :each do
          @user = Fabricate(:user)
          session[:user_id] = @user
          @queue_item_1 = Fabricate(:queue_item, user: @user, position: 1)
          @queue_item_2 = Fabricate(:queue_item, user: @user, position: 2)
          @queue_item_3 = Fabricate(:queue_item, user: @user, position: 3)
        end

        it "redirects to my queue" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "1" },
                                   { "id" => @queue_item_2.id, "position" => "4" },
                                   { "id" => @queue_item_3.id, "position" => "3" }]
          expect(response).to redirect_to my_queue_path
        end

        it "normalies the position numbers" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "1" },
                                   { "id" => @queue_item_2.id, "position" => "4" },
                                   { "id" => @queue_item_3.id, "position" => "3" }]
          expect(@queue_item_1.reload.position).to eq 1
          expect(@queue_item_2.reload.position).to eq 3
          expect(@queue_item_3.reload.position).to eq 2
        end

        it "does not update other user's queue items" do
          user_2 = Fabricate(:user)
          queue_item_3 = Fabricate(:queue_item, user: user_2, position: 1)
          queue_item_4 = Fabricate(:queue_item, user: user_2, position: 2)
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "1" },
                                   { "id" => @queue_item_2.id, "position" => "4" },
                                   { "id" => @queue_item_3.id, "position" => "3" }]
          expect(queue_item_3.reload.position).to eq 1
          expect(queue_item_4.reload.position).to eq 2 
        end
      end
    end

    context "with invalid input" do
      context "character" do
        before :each do
          @user = Fabricate(:user)
          session[:user_id] = @user
          @queue_item_1 = Fabricate(:queue_item, user: @user, position: 1)
          @queue_item_2 = Fabricate(:queue_item, user: @user, position: 2)
        end

        it "redirects to my queue" do
          patch :update_queue, "queue_items" =>          
                                  [{ "id" => @queue_item_1.id, "position" => "1" },
                                   { "id" => @queue_item_2.id, "position" => "t" }]
          expect(response).to redirect_to my_queue_path
        end

        it "sets warning message" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "1" },
                                   { "id" => @queue_item_2.id, "position" => "t" }]
          expect(flash[:warning]).to_not be_blank
        end

        it "does not change positions" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "2" },
                                   { "id" => @queue_item_2.id, "position" => "t" }]
          expect(@queue_item_1.reload.position).to eq 1
          expect(@queue_item_2.reload.position).to eq 2 
        end
      end

      context "number range" do
        before :each do
          @user = Fabricate(:user)
          session[:user_id] = @user
          @queue_item_1 = Fabricate(:queue_item, user: @user, position: 1)
          @queue_item_2 = Fabricate(:queue_item, user: @user, position: 2)
        end

        it "sets warning message" do
          patch :update_queue, "queue_items" =>
                                 [{ "id" => @queue_item_1.id, "position" => "1" },
                                  { "id" => @queue_item_2.id, "position" => "5" }]
          expect(flash[:warning]).to_not be_blank
        end

        it "does not change positions" do
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "2" },
                                   { "id" => @queue_item_2.id, "position" => "5" }]
          expect(@queue_item_1.reload.position).to eq 1
          expect(@queue_item_2.reload.position).to eq 2 
        end
      end

      context "duplicate entries" do
        before :each do
          @user = Fabricate(:user)
          session[:user_id] = @user
          @queue_item_1 = Fabricate(:queue_item, user: @user, position: 1)
          @queue_item_2 = Fabricate(:queue_item, user: @user, position: 2)
          patch :update_queue, "queue_items" =>
                                  [{ "id" => @queue_item_1.id, "position" => "2" },
                                   { "id" => @queue_item_2.id, "position" => "2" }]
        end

        it "sets warning message" do
          expect(flash[:warning]).to_not be_blank
        end

        it "does not change positions" do
          expect(@queue_item_1.reload.position).to eq 1
          expect(@queue_item_2.reload.position).to eq 2 
        end
      end
    end
  end
end








