require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated users" do
      let(:desmond) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: desmond) }
      let(:queue_item2) { Fabricate(:queue_item, user: desmond) }
      before do
        set_current_user(desmond)
      end
      it "sets the @queue_items to the queue items of current user" do
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
      it "should render the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "with unuthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      let(:desmond) { Fabricate(:user) }
      before do
        set_current_user(desmond)
      end
      it "should redirect to my_queue page" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "should create a queue item" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "should create a queue item associate with video" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "should create a queue item associate with current user" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(desmond)
      end
      it "puts item as the last one of the queue" do
        video1 = Fabricate(:video)
        Fabricate(:queue_item, user: desmond, video: video1)
        video2 = Fabricate(:video)
        post :create, video_id: video2.id
        queue_item = QueueItem.where(user: desmond, video: video2).first
        expect(queue_item.position).to eq(2)
      end
      it "deoes not add video in the queue if it is already in" do
        video1 = Fabricate(:video)
        QueueItem.create(user: desmond, video: video1)
        post :create, video_id: video1.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "with unuthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, video_id: 3 }
      end
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      let(:desmond) { Fabricate(:user) }
      before do
        set_current_user(desmond)
      end
      it "should redirect to my queue page" do
        queue_item = Fabricate(:queue_item, user: desmond)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
      it "should delete the queue item" do
        queue_item = Fabricate(:queue_item, user: desmond)
        delete :destroy, id: queue_item.id
        expect(desmond.queue_items.count).to eq(0)
      end
      it "should normalize the remaining queue" do
        queue_item1 = Fabricate(:queue_item, user: desmond, position: 1)
        queue_item2 = Fabricate(:queue_item, user: desmond, position: 2)
        delete :destroy, id: queue_item1.id
        expect(desmond.queue_items.first.position).to eq(1)
      end
      it "should not delete the queue item if it is not own by current user" do
        alice = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: alice)
        delete :destroy, id: queue_item.id
        expect(alice.queue_items.count).to eq(1)
      end
    end

    context "with unuthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { delete :destroy, id: 3 }
      end
    end
  end

  describe "POST update_queue" do
    context "with authenticated users" do
      context "with valid input" do
        let(:desmond) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        before do
          set_current_user(desmond)
        end
        it "should redirect to my queue page" do
          queue_item1 = Fabricate(:queue_item, position: 1, user: desmond, video: video)
          queue_item2 = Fabricate(:queue_item, position: 2, user: desmond, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        it "should reorder the queue" do
          queue_item1 = Fabricate(:queue_item, position: 1, user: desmond, video: video)
          queue_item2 = Fabricate(:queue_item, position: 2, user: desmond, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(desmond.queue_items).to eq([queue_item2, queue_item1])
        end
        it "should normalize the queue" do
          queue_item1 = Fabricate(:queue_item, position: 1, user: desmond, video: video)
          queue_item2 = Fabricate(:queue_item, position: 2, user: desmond, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1}]
          expect(desmond.queue_items.map(&:position)).to eq([1, 2])
        end
        it "should not update queue items which are not belongs to current user" do
          alice = Fabricate(:user)
          queue_item1 = Fabricate(:queue_item, position: 1, user: desmond, video: video)
          queue_item2 = Fabricate(:queue_item, position: 2, user: alice, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1}]
          expect(queue_item2.reload.position).to eq(2)
        end
      end

      context "with invalid input" do
        let(:desmond) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        let(:queue_item1) { Fabricate(:queue_item, position: 1, user: desmond, video: video) }
        let(:queue_item2) { Fabricate(:queue_item, position: 2, user: desmond, video: video) }
        before do
          set_current_user(desmond)
        end
        it "should redirect to my queue page" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3.5}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        it "should show the danger message" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
          expect(flash[:danger]).to be_present
        end
        it "should not update the queue" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
          expect(queue_item1.reload.position).to eq(1)
        end
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :update_queue }
      end
    end
  end
end
