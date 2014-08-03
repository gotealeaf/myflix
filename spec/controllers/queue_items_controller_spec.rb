require 'spec_helper'

describe QueueItemsController do

  let(:current_user) { Fabricate(:user) }
  let(:another_user) { Fabricate(:user) }
  let(:video1) { Fabricate(:video) }
  let(:video2) { Fabricate(:video) }
  let!(:queue_item1) { Fabricate(:queue_item, ranking: 1, creator: current_user, video: video1) }
  let!(:queue_item2) { Fabricate(:queue_item, ranking: 2, creator: current_user, video: video2) }
  let!(:another_queue_item1) { Fabricate(:queue_item, ranking: 1, creator: another_user, video: video1) }
  let!(:another_queue_item2) { Fabricate(:queue_item, ranking: 2, creator: another_user, video: video2) }

  describe "GET index" do

    context "with authenticated user" do

      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "assigns @queue_items" do
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
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

    before {  }

    context "with authenticated user" do
      let(:video3) { Fabricate(:video) }
      before do
        session[:user_id] = current_user.id
        post :create, id: Fabricate(:video).id
        post :create, id: video3.id
      end

      it "creates a queue_item" do
        expect(current_user.queue_items.count).to eq(4)
      end

      it "assoicates with user" do
        expect(QueueItem.last.creator).to eq(current_user)
      end

      it "assoicates with video" do
        expect(QueueItem.last.video).to eq(video3)
      end

      it "pull to last ranking" do
        expect(current_user.queue_items.last.ranking).to eq(4)
      end

      it "does not add the same video" do
        post :create, id: video1.id
        expect(current_user.queue_items.count).to eq(4)
      end

      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end
    end

    context "with unauthenticated user" do

      it "redirects to signin_path" do
        post :create,  video: video1
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "POST update" do

    context "with authenticated user" do

      before { session[:user_id] = current_user.id }

      context "with valid input" do

        before do
          post :update_queue, queue_items: [{ id: queue_item1.id, ranking: 3 }, { id: queue_item2, ranking: 2 }]
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

      before do
        session[:user_id] = current_user.id
        post :update_queue, queue_items: [{ id: another_queue_item1.id, ranking: 3 }, { id: another_queue_item2, ranking: 2 }]
      end

      it "does not change the ranking" do
        expect(another_user.queue_items).to eq([another_queue_item1, another_queue_item2])
      end
    end
  end

  describe "DELETE destroy" do

    context "with anuthenticated user" do

      before do
        session[:user_id] = current_user.id
        delete :destroy, id: queue_item1.id
      end


      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end

      it "deletes the queue item" do
        expect(current_user.queue_items.count).to eq(1)
      end

      it "does not delete non-current user's queue item" do
        delete :destroy, id: another_queue_item1.id
        expect(another_user.queue_items.count).to eq(2)
      end

      it "reset the order" do
        expect(queue_item2.reload.ranking).to eq(1)
      end
    end

    context "with unanthenticated user" do

      before { delete :destroy, id: queue_item1.id }

      it "redirects to signin_path" do
        expect(response).to redirect_to signin_path
      end
    end
  end
end
