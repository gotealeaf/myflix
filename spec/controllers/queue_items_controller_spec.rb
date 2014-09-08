require 'spec_helper'

describe QueueItemsController do

############################################

  describe "delete item" do
    context "user logged in" do
      before do
        @rick = Fabricate(:user)
        session[:user_id] = @rick.id
        @monk = Fabricate(:video)
        @q1   = Fabricate(:queue_item, position: 1, video: @monk, user: @rick)
      end

      it "renders the template" do
        delete :destroy, id: @q1.id
        response.should redirect_to my_queue_path
      end

      it "removes the item" do
        delete :destroy, id: @q1.id
        QueueItem.count.should == 0
      end
 
      it "does not remove a queue item from another user" do
        @ellen = Fabricate(:user)
        @q2   = Fabricate(:queue_item, position: 2, video: @conk, user: @ellen)
        delete :destroy, id: @q2.id
        QueueItem.count.should == 2
      end

=begin
      it "repositions the items" do
        @conk = Fabricate(:video)
        @q2   = Fabricate(:queue_item, position: 2, video: @conk, user: @rick)
        delete :destroy, id: @q1.id
        QueueItem.first.position.should == 1
      end
=end

    end

    context "user NOT logged in" do
      it "redirects to sign_in" do
        delete :destroy, id: 1
        response.should redirect_to sign_in_path
      end
    end
  end

############################################


  describe 'GET index' do
    context "user logged in" do
      before do
        @rick = Fabricate(:user)
        session[:user_id] = @rick.id
        @monk = Fabricate(:video)
        @conk = Fabricate(:video)
        @q1   = Fabricate(:queue_item, position: 2, user: @rick)
        @q2   = Fabricate(:queue_item, position: 1, user: @rick)
      end

      it "prepares the queue items for the current user" do
        get :index
  #puts assigns(:categories).inspect
  #      binding.pry
        assigns(:queue_items).should == [@q2,@q1]
      end

      it "renders the template" do
        get :index
        response.should render_template :index
      end

    end

    context "user NOT logged in" do
      it "renders redirect to sign_in" do
        get :index
        response.should redirect_to sign_in_path
      end
    end
  end 

#####################################################

  describe 'POST create' do
    context "user logged in" do
      before do
        @rick = Fabricate(:user)
        session[:user_id] = @rick.id
        @monk = Fabricate(:video)
      end

      it "redirects to my queue" do
        post :create, video_id: @monk.id, user_id: @rick.id
        response.should redirect_to my_queue_path
      end

      it "updates the queue item" do
        post :create, video_id: @monk.id, user_id: @rick.id
        QueueItem.count.should == 1
      end

      it "the queue item is associated with the video" do
        post :create, video_id: @monk.id, user_id: @rick.id
        QueueItem.first.video.should == @monk
      end

      it "the queue item is associated with the user" do
        post :create, video_id: @monk.id, user_id: @rick.id
        QueueItem.first.user.should == @rick
      end

      it "the queue item is in the last position for the user" do
        @q1   = Fabricate(:queue_item, position: 1, video: @monk,  user: @rick)
        @donk = Fabricate(:video)
        post :create, video_id: @donk.id, user_id: @rick.id
        QueueItem.last.position.should == 2
      end

      it "does not create a duplicate queue item" do
        @q1   = Fabricate(:queue_item, position: 1, video: @monk,  user: @rick)
        post :create, video_id: @monk.id, user_id: @rick.id
        QueueItem.count.should == 1
      end

    end
    context "user NOT logged in" do
      it "redirects to sign_in" do
        post :create
        response.should redirect_to sign_in_path
      end
    end

  end
#####################################################

end
