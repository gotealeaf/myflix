require 'spec_helper'

describe QueuesController do

  let(:user)  { Fabricate(:user) }
  let(:video) { Fabricate(:video) }
  let!(:queue_target) { QueueItem.where(user: user).count + 1 }

  describe "queues#create" do
    context "logged in" do
      before(:each) do
        set_current_user
        post :create, id: video
      end
      it "sets user relationship" do
        expect(assigns(:queue_item).user).to eq user
      end
      it "sets video relationship" do
        expect(assigns(:queue_item).video).to eq video
      end
      it "sets position as last item" do
        expect(assigns(:queue_item).position).to eq queue_target 
      end
      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end
      it "creates nothing if already created" do
        expect {
          post :create, id: video
        }.to change(QueueItem, :count).by(0)
      end
    end

    it_behaves_like "require_sign_in" do
      let(:action)  { post :create, user_id: user.id, video_id: video.id }
    end
  end

  describe "queues#destroy" do
    context "logged in" do
      let(:queue_item) { Fabricate(:queue_item_same_user, user: user) }
      before do
        set_current_user
      end
      it "deletes requested queue_item" do
        delete :destroy, id: queue_item
        expect(QueueItem.count).to eq 0
      end
      it "redirects to my_queue_path" do
        delete :destroy, id: queue_item
        expect(response).to redirect_to my_queue_path
      end
      it "rearranges list order to right order" do
        Fabricate.times(4, :queue_item_same_user, user: user)
        delete :destroy, id: 2
        expect(QueueItem.all.map(&:position)).to eq [1,2,3]
      end
    end
    it_behaves_like "require_sign_in" do
      let(:action) {
        queue_item = Fabricate(:queue_item_same_user, user: user) 
        # WHY can not use obj defined by let(:queue_item)
        delete :destroy, id: queue_item
      }
    end
    it "do nothing if it is not current user's queue" do
      queue_item_another_user = Fabricate(:queue_item_same_user, user: Fabricate(:user)) 
      set_current_user
      expect{
        delete :destroy, id: queue_item_another_user
      }.to change(QueueItem, :count).by(0)
    end
  end


  describe "queues#update_instant (update my_queue data)" do
    context "authuentication"do
      it "redirects to root_path if not logging in" do
        post :update_instant
        expect(response).to redirect_to root_path
      end
      it "do nothing if queue_item's user not equal current user" do
        set_current_user
        user2 = Fabricate(:user)
        Fabricate.times(2, :queue_item_same_user, user: user2)
        post :update_instant, queue_items: {
            "1" => { position: "2" },
            "2" => { position: "1" }
          }
        expect(QueueItem.all.map(&:position)).to eq [1,2]
      end
    end 

    context "no queue" do        
      it "redirect to my_queue" do
        post :update_instant
      end
    end
    context "single queue" do
      before do
        set_current_user
        @review = Fabricate(:review, user: user, video: video,rating: 4) 
        @queue_item = Fabricate(:queue_item, user: user, video: video )
        post :update_instant, queue_items: { @queue_item.id.to_s => { rating: "3", position: "1" }  }
      end
      it "saves rating" do
        expect(QueueItem.first.rating).to eq 3
      end
    end 

    context "mutiple queue" do
      before do
        Fabricate.times(3, :queue_item_same_user, user: user)
        set_current_user
      end
      it "saves all list orders if all vlidation of list order pass" do
        post :update_instant, queue_items: { 
          "1" => { position: "3" }, 
          "2" => { position: "2" }, 
          "3" => { position: "1" }
        }
        queue_items_positions = QueueItem.all.each.map(&:position)
        expect(queue_items_positions).to eq [3,2,1]
      end
      it "not saves all list orders if one of queue_item's validation of list order not pass" do
        post :update_instant, queue_items: { 
          "1" => { position: "1" }, 
          "2" => { position: "2" }, 
          "3" => { position: "1" }
        }
        queue_items_positions = QueueItem.all.each.map(&:position)
        expect(queue_items_positions).to eq [1,2,3]
      end
      it "quicklly change list order to buttom by assign it's list order to maxium of list order now + 1" do
        post :update_instant, queue_items: { 
          "1" => { position: "4" }, 
          "2" => { position: "2" }, 
          "3" => { position: "3" }
        }
        queue_items_positions = QueueItem.all.each.map(&:position)
        expect(queue_items_positions).to eq [3,1,2]
      end
      it "creates review when queue_item have no review and save rating to it" do
        review = Fabricate(:review, user: user, video: video, rating: 1) 
        Fabricate(:queue_item, user: user, video: video)
        post :update_instant, queue_items: { 
          "1" => { position: "1", rating: "1" }, 
          "2" => { position: "2", rating: "3" }, 
          "3" => { position: "3", rating: "4" },
          "4" => { position: "4", rating: "5 "}
        }
        queue_items_ratings = QueueItem.all.map{ |f| f.rating }
        expect(queue_items_ratings).to eq [1,3,4,5]           
      end
    end
  end
end




















