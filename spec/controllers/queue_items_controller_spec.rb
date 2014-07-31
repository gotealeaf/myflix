require 'spec_helper'


describe QueueItemsController do
  let(:video1) { Fabricate(:video) }
  let(:video2) { Fabricate(:video) }
  describe "GET index" do
    context "with authenticated user" do
      before { set_current_user }
      let(:item1) { Fabricate(:queue_item, ranking: 1, creator: current_user) }
      let(:item2) { Fabricate(:queue_item, ranking: 2, creator: current_user) }

      before { get :index}

      it "assigns @queue_items" do
        expect(assigns(:queue_items)).to match_array([item1, item2])
      end

      it "renders template :index" do
        get :index
        expect(response).to render_template :index
      end
    end

    it "redirects to signin_path with unauthenticated user" do
      get :index
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST create" do
    context "with authenticated user" do
      before { set_current_user }
      context "with valid input" do
        before do
          post :create, video_id: video1.id
          post :create, video_id: video2.id
        end

        it "creates a queue_item" do
          expect(QueueItem.count).to eq(2)
        end
        it "assoicates with user" do
          expect(QueueItem.first.creator).to eq(current_user)
        end
        it "assoicates with video" do
          expect(QueueItem.first.video).to eq(video1)
        end

        it "pull to last position" do
          expect(QueueItem.last.ranking).to eq(2)
        end

        it "does not add the same video" do
          post :create, video_id: video1.id
          expect(QueueItem.count).to eq(2)
        end
        it "redirects to my_queue_path" do
          expect(response).to redirect_to my_queue_path
        end
      end
    end

    context "with unauthenticated user" do
      it "redirects to signin_path" do
        post :create,  video_id: video1.id
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "POST update" do
    context "with authenticated user" do
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, ranking: 1, creator: current_user, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, ranking: 2, creator: current_user, video: video) }
      before { set_current_user }

      context "with valid input" do
        before do
          post :update_queue, queue_items: [{ id: queue_item1.id, ranking: 3 },
             { id: queue_item2, ranking: 2 }]
        end

        it "reset the ranking numbers" do
          expect(current_user.queue_items).to eq([queue_item2, queue_item1])
        end

        it "reset the order square" do
          expect(current_user.queue_items.map(&:ranking)).to eq([1,2])
        end
        it "redirects to my_queue_path" do
          expect(response).to redirect_to my_queue_path
        end
      end


      context "with invalid input" do
        before do
          post :update_queue, queue_items: [{ id: queue_item1.id, ranking: 3.4 }, { id: queue_item2, ranking: 1 }]
        end
        it "does not change the ranking numbers" do
          expect(queue_item2.reload.ranking).to eq(2)
        end

        it "redirects to my_queue_path" do
          expect(response).to redirect_to my_queue_path
        end

        it "sets flash meassage" do
          expect(flash[:warning]).not_to be_blank
        end
      end
    end

    context "with unanthenticated user" do
      it "redirects to signin_path" do
        post :update_queue, queue_items: [{ id: 1, ranking: 1 }]
        expect(response).to redirect_to signin_path
      end
    end

    context "when queue item do not belongs to current_user" do
      let(:another_user) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, ranking: 1, creator: another_user) }
      let(:queue_item2) { Fabricate(:queue_item, ranking: 2, creator: another_user) }
      before do
        set_current_user
        post :update_queue, queue_items: [{ id: queue_item1.id, ranking: 3 },
           { id: queue_item2, ranking: 2 }]
      end
      it "does not change the ranking" do
        expect(another_user.queue_items).to eq([queue_item1, queue_item2])
      end

    end
  end

  describe "DELETE destroy" do
    context "with anuthenticated user" do
      before { set_current_user }
      let!(:another_user) { Fabricate(:user) }
      let!(:queue_item1) { Fabricate(:queue_item, ranking: 1, user_id: current_user.id) }
      let!(:queue_item2) { Fabricate(:queue_item, ranking: 2, user_id: current_user.id) }
      let!(:another_user_item) { Fabricate(:queue_item, ranking: 1, user_id: another_user.id) }
      it "redirects to my_queue_path" do
        delete :destroy, id: queue_item1.id
        expect(response).to redirect_to my_queue_path
      end

      it "deletes the queue item" do
        delete :destroy, id: queue_item1.id
        expect(QueueItem.count).to eq(2)
      end

      it "does not delete non-current user's queue item" do
        delete :destroy, id: another_user_item.id
        expect(QueueItem.count).to eq(3)
      end

      it "reset the order" do
        delete :destroy, id: queue_item1.id
        expect(queue_item2.reload.ranking).to eq(1)
      end
    end

    context "with unanthenticated user" do
      let(:queue_item) { Fabricate(:queue_item, ranking: 1) }
      before { delete :destroy, id: queue_item.id }

      it "redirects to signin_path" do
        expect(response).to redirect_to signin_path
      end
    end
  end
end
