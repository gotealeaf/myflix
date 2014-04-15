require 'spec_helper'

describe QueueItemsController do
  before { set_current_user }

  describe "GET index" do
    let(:queue_item_1) { Fabricate(:queue_item, user: current_user, position: 1) }
    let(:queue_item_2) { Fabricate(:queue_item, user: current_user, position: 2) }

    before { queue_item_1; queue_item_2; get :index }

    it "renders the queue template" do
      expect(response).to render_template 'users/my_queue'
    end

    it "sets @queue_items to the current user's queue_items" do
      expect(assigns(:queue_items)).to match_array([queue_item_1, queue_item_2])
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it "redirects to my_queue_path" do
      post :create, video_id: Fabricate(:video).id
      expect(response).to redirect_to my_queue_path
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    context "video is not in user queue" do
      let(:video) { Fabricate(:video) }
      let(:action) { post :create, video_id: video.id }

      it "creates a queue_item associated with the video and current user" do
        action
        expect(QueueItem.first.video).to eq video
        expect(QueueItem.first.user).to eq current_user
      end

      it "assigns the next available queue position for the current user to the new queue_item" do
        Fabricate(:queue_item, user: current_user)
        action
        expect(QueueItem.find_by(video: video).position).to eq 2
      end

      it "assigns the first position to the new queue_item if none exist for the current user" do
        action
        expect(QueueItem.first.position).to eq 1
      end
    end

    context "video is in user queue" do
      let(:video) { Fabricate(:video) }

      before do
        Fabricate(:queue_item, video: video, user: current_user)
        post :create, video_id: video.id
      end

      it "does not save the video as a new queue_item" do
        expect(QueueItem.count).to eq 1
      end

      it "sets the warning message" do
        expect(flash[:warning]).to_not be_blank
      end

      it "redirects to the video page" do
        expect(response).to redirect_to video
      end
    end
  end

  describe "DELETE destroy" do
    it "redirects to my queue" do
      delete :destroy, id: Fabricate(:queue_item, user: current_user).id
      expect(response).to redirect_to my_queue_path
    end

    it "removes the deleted queue_item from the db" do
      delete :destroy, id: Fabricate(:queue_item, user: current_user).id
      expect(QueueItem.count).to eq 0
    end

    it "does not delete queue_item if not in the current user's queue" do
      user = Fabricate(:user)
      delete :destroy, id: Fabricate(:queue_item, user: user).id
      expect(QueueItem.count).to eq 1
    end

    it "normalizes the remaining queue_item positions" do
      queue_item_1 = Fabricate(:queue_item, user: current_user, position: 1)
      queue_item_2 = Fabricate(:queue_item, user: current_user, position: 2)
      delete :destroy, id: queue_item_1.id
      expect(current_user.queue_items.first.position).to eq 1
    end

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: Fabricate(:queue_item) }
    end
  end

  describe "PATCH update_queue" do
    it_behaves_like "require_sign_in" do
      let(:action) { patch :update_queue }
    end

    context "with valid input" do
      let(:video) { Fabricate(:video) }
      let(:queue_item_1) { Fabricate(:queue_item, user: current_user, video: video, position: 1) }
      let(:queue_item_2) { Fabricate(:queue_item, user: current_user, position: 2) }
      let(:queue_item_3) { Fabricate(:queue_item, user: current_user, position: 3) }

      it "redirects to my queue" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "2" },
                                           { id: queue_item_2.id, position: "1" }]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue_items" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "2" },
                                           { id: queue_item_2.id, position: "1" }]
        expect(current_user.queue_items.map(&:id)).to eq [2, 1]
      end

      it "normalizes the position numbers" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "1" },
                                           { id: queue_item_2.id, position: "4" },
                                           { id: queue_item_3.id, position: "3" }]
        expect(current_user.queue_items.map(&:id)).to eq [1, 3, 2]
      end

      it "does not update other user's queue items" do
        user_2 = Fabricate(:user)
        queue_item_4 = Fabricate(:queue_item, user: user_2, position: 1)
        patch :update_queue, queue_items: [{ id: queue_item_4.id, position: "3" }]
        expect(user_2.queue_items.count).to eq 1
      end

      it "sets the rating" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: 1, rating: 3 }]
        expect(current_user.queue_items.first.rating).to eq 3 
      end
    end

    context "with invalid input" do
      let(:queue_item_1) { Fabricate(:queue_item, user: current_user, position: 1) }
      let(:queue_item_2) { Fabricate(:queue_item, user: current_user, position: 2) }

      it "redirects to my queue" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "t" }]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the warning message" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "1.2" }]
        expect(flash[:warning]).to_not be_blank
      end

      it "does not change positions" do
        patch :update_queue, queue_items: [{ id: queue_item_1.id, position: "2" },
                                           { id: queue_item_2.id, position: "t" }]
        expect(current_user.queue_items.map(&:id)).to eq [1, 2]
      end  
    end
  end
end