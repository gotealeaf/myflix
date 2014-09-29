require 'spec_helper'

describe QueueItemsController do

############################################

  describe "update all queue items" do
    
    context "user logged in" do
      before do
        set_current_user
        @rick = current_user
        @monk = Fabricate(:video)
        @q1   = Fabricate(:queue_item, position: 1, video: @monk, user: @rick)
        @donk = Fabricate(:video)
        @q2   = Fabricate(:queue_item, position: 2, video: @donk, user: @rick)
      end

      it "populates the array of hashes" do
        @qis = [{"id"=>"1", "position"=>"2"}, {"id"=>"2", "position"=>"1"}]
        post :update, "queue_items"=> @qis
        assigns[:queue_items].should == @qis
      end

      it "saves all the values when valid" do
        @qis = [{"id"=>"1", "position"=>"2"}, {"id"=>"2", "position"=>"1"}]
        post :update, "queue_items"=> @qis
        QueueItem.all.map(&:position).should == [2,1]
      end

      it "saves normalizes the order when valid" do
        @qis = [{"id"=>"1", "position"=>"13"},{"id"=>"2", "position"=>"4"}]
        post :update, "queue_items"=> @qis
        QueueItem.all.map(&:position).should == [2,1]
      end

      it "saves NONE of the values when INvalid" do
        @qis = [{"id"=>"1", "position"=>"green"}, {"id"=>"2", "position"=>"blue"}]
        post :update, "queue_items"=> @qis
        QueueItem.all.map(&:position).should == [1,2]
      end

      it "gives the user an error when when INvalid" do
        @qis = [{"id"=>"1", "position"=>"green"}, {"id"=>"2", "position"=>"blue"}]
        post :update, "queue_items"=> @qis
        flash[:errors].should_not be_blank
      end

      it "saves NONE of the values when a queue item does not belong to the user" do
        @ellen = Fabricate(:user)
        @q3   = Fabricate(:queue_item, position: 3, video: @donk, user: @ellen)
        @qis = [{"id"=>"1", "position"=>"2"},{"id"=>"2", "position"=>"3"}, {"id"=>"3", "position"=>"5"}]
        post :update, "queue_items"=> @qis
        QueueItem.all.map(&:position).should == [1,2,3]
      end

      it "redirects to index" do
        @qis = [{"id"=>"1", "position"=>"2"}, {"id"=>"2", "position"=>"1"}]
        post :update, "queue_items"=> @qis
        response.should redirect_to my_queue_path
      end
    end

    context "user NOT logged in" do
      it_behaves_like "require_sign_in" do
        let(:action) {post :update}
      end
    end

  end



############################################

  describe "delete item" do
    context "user logged in" do
      before do
        set_current_user
        @rick = current_user
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

      it "repositions the items" do
        @conk = Fabricate(:video)
        @q2   = Fabricate(:queue_item, position: 2, video: @conk, user: @rick)
        delete :destroy, id: @q1.id
        QueueItem.first.position.should == 1
      end

    end

    context "user NOT logged in" do
      it_behaves_like "require_sign_in" do
        let(:action) {delete :destroy, id: 1}
      end
    end
  end

############################################


  describe 'GET index' do
    context "user logged in" do
      before do
        set_current_user
        @rick = current_user
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
      it_behaves_like "require_sign_in" do
        let(:action) {get :index}
      end

    end
  end 

#####################################################

  describe 'POST create' do
    context "user logged in" do
      before do
        set_current_user
        @rick = current_user
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
      it_behaves_like "require_sign_in" do
        let(:action) {post :create}
      end
    end

  end
#####################################################

end
