require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'GET #index' do
    context 'with valid user' do
      let(:adam) { Fabricate(:user) }
      before do
        add_to_session(adam)
      end
      it 'sets the @queue_items instance variable correctly' do
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        get :index
        expect(assigns(:queue_items)).to match_array([qitem, qitem2])
      end
      it 'renders the show template' do
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'with invalid user' do
      it 'redirects user' do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user logged in' do
      let(:adam) { Fabricate(:user) }
      let(:monk) { Fabricate(:video) }
      before do
        add_to_session(adam)
        Fabricate(:queue_item, user: adam, video: monk)
      end
      context 'user working on their own queue_items' do
        before do
          delete :destroy, id: QueueItem.first.id
        end
        it 'redirects the user to the my queue page' do
          expect(response).to redirect_to my_queue_path
        end
        it 'deletes the video from the users queue' do
          expect(QueueItem.count).to eq(0)
        end
        it 'shows a confirmation msg to the user if the deletion is successful' do
          expect(flash[:success]).to be_present
        end
      end
      context 'user altering another queue items' do
        before do
          queue_item_2 = Fabricate(:queue_item, video: monk)
          delete :destroy, id: queue_item_2.id
        end
        it 'prevents a user from deleting another users queue item' do
          expect(QueueItem.count).to eq(2)
        end
        it 'displays an error if the user does not own the queue item' do
          expect(flash[:danger]).to be_present
        end
      end
    end
    context 'user not logged in' do
      it 'redirects unauthenticated user to the login page' do
        queue_item_2 = Fabricate(:queue_item)
        delete :destroy, id: queue_item_2.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST update_order' do
    context 'invalid inputs' do
      it 'shows error if queue item is no valid number' do
        adam = Fabricate(:user)
        add_to_session(adam)
        queue_item1 = Fabricate(:queue_item, user: adam, position: 1)
        queue_item2 = Fabricate(:queue_item, user: adam, position: 2)
        post :update_order, queue_items: [{'id'=>"#{queue_item1.id}", "position"=>"/7."}, {'id'=>"#{queue_item2.id}", "position"=>"1"}]
        expect(flash[:danger]).to be_present
      end
    end
    context 'valid inputs' do
      let(:adam) { Fabricate :user }
      let(:queue_item1) { Fabricate(:queue_item, user_id: adam.id, position: 1)}
      let(:queue_item2) { Fabricate(:queue_item, user_id: adam.id, position: 2)}
      before do
        add_to_session(adam)
        post :update_order, queue_items: [{'id'=>"#{queue_item1.id}", 'position'=>"7"}, {"id"=>"#{queue_item2.id}", 'position'=>'5'}]
      end
      it 'redirects the user to the my queue page' do
        expect(response).to redirect_to my_queue_path
      end
      context 'alters queue order' do
        before do
          expect(QueueItem.find(queue_item1.id).position).to eq(2)
          expect(QueueItem.find(queue_item2.id).position).to eq(1)
        end
        it 'updates the order of the queue' do
        end
        it 'resets the order of the queue items' do
        end
      end
      it 'shows a confirmation message' do
        expect(flash[:success]).to be_present
      end
    end

    context 'unauthenticated users' do
      it_behaves_like "require_logged_in_user" do
        let(:queue_item1) { Fabricate(:queue_item, position: 1)}
        let(:queue_item2) { Fabricate(:queue_item, position: 2)}
        let(:action) { post :update_order, queue_item: [{'id'=>"#{queue_item1.id}", 'position'=>"3"}, {"id"=>"#{queue_item2.id}", 'position'=>'1'}] }
      end
    end
    context 'user submits queue_item that they do not own' do
      let(:adam) { Fabricate :user }
      let(:queue_item1) { Fabricate(:queue_item, user_id: adam.id, position: 1)}
      let(:queue_item2) { Fabricate(:queue_item, user_id: adam.id, position: 2)}
      let(:queue_item3) { Fabricate(:queue_item, position: 15) }
      let(:queue_item4) { Fabricate(:queue_item, position: 14) }
      let(:queue_item5) { Fabricate(:queue_item, position: 68) }
      before do
        add_to_session(adam)
        post :update_order, queue_items: [{'id'=>"#{queue_item5.id}", "position"=>"14"}, {'id'=>"#{queue_item1.id}", 'position'=>'34'}, {'id'=>"#{queue_item3.id}", "position"=>"14"}, {'id'=>"#{queue_item4.id}", "position"=>"14"}]
      end
      it 'fails to update queue' do
        expect(QueueItem.find(queue_item3.id).position).to eq(15)
      end
      it 'redirect_to my_queue_path' do
        expect(response).to redirect_to my_queue_path
      end
      it 'shows error message' do
        expect(flash[:danger]).to be_present
      end
    end
    context 'user submits rating info' do
      let(:adam) { Fabricate :user }
      let(:video1) { Fabricate :video }
      let(:queue_item1) { Fabricate(:queue_item, user_id: adam.id, position: 1, video_id: video1.id)}
      let(:queue_item2) { Fabricate(:queue_item, user_id: adam.id, position: 2)}
      let(:queue_item3) { Fabricate(:queue_item, position: 15) }
      let(:queue_item4) { Fabricate(:queue_item, position: 14) }
      let(:queue_item5) { Fabricate(:queue_item, position: 68) }
      before do
        add_to_session(adam)
        Fabricate(:review, video_id: video1.id, rating: 1, content: "this is a really good review", user_id: adam.id)
        post :update_order, queue_items: [{'id'=>"#{queue_item1.id}", 'position'=>'34', 'rating'=>'2  Stars'}, {'id'=>"#{queue_item2.id}", 'position'=>'66', 'rating'=>'3  Stars'}]
      end
      it 'updates the video ratings'  do
        expect(Review.first.rating).to eq(2)
      end
      it 'redirects to my_queue_path' do
        expect(response).to redirect_to my_queue_path
      end
    end
    context 'user adds review to video that didnt have one before' do
      let(:adam) { Fabricate :user }
      let(:video1) { Fabricate :video }
      let(:queue_item1) { Fabricate(:queue_item, user_id: adam.id, position: 1, video_id: video1.id)}
      let(:queue_item2) { Fabricate(:queue_item, user_id: adam.id, position: 2)}
      let(:queue_item3) { Fabricate(:queue_item, position: 15) }
      let(:queue_item4) { Fabricate(:queue_item, position: 14) }
      let(:queue_item5) { Fabricate(:queue_item, position: 68) }
      before do
        add_to_session(adam)
        Fabricate(:review, video_id: video1.id, rating: 1, content: "this is a really good review", user_id: adam.id)
        post :update_order, queue_items: [{'id'=>"#{queue_item1.id}", 'position'=>'34', 'rating'=>'2  Stars'}, {'id'=>"#{queue_item2.id}", 'position'=>'66', 'rating'=>'3  Stars'}]
      end
      it 'submits a review for an video that doenst already have a review' do
        expect(Review.count).to eq(2)
      end
    end
  end

  describe 'POST #create' do
    let(:adam) { Fabricate :user }
    let(:monk) { Fabricate :video }
    let(:sample_queue_item) { Fabricate.attributes_for(:queue_item, user_id: adam.id, video_id: monk.id) }
    context 'user signed in' do
      before do
        add_to_session(adam)
      end
      context 'the video is already in the queue' do
        let!(:monk_queue_item) { Fabricate(:queue_item, user_id: adam.id, video_id: monk.id) }
        before do
          post :create, qitem: sample_queue_item
        end
        it 'fails to save the video to the queue' do
          expect(QueueItem.count).to eq(1)
        end
        it 'shows a error message to the user' do
          expect(flash[:danger]).to be_present
        end
        it_behaves_like "redirect_to my_queue_path" do
          let(:action) { post :create, qitem: sample_queue_item }
        end
      end
      context 'the video is not already in the queue' do
        it 'saves the video to the queue' do
          post :create, qitem: sample_queue_item
          expect(QueueItem.count).to eq(1)
        end
        it 'adds the queue to the back of the queue' do
          @position = 0
          2.times do
            Fabricate(:queue_item, user_id: adam.id, position: @position + 1)
            @position = @position + 1
          end
          post :create, qitem: sample_queue_item
          expect(assigns(:queue_item).position).to eq(3)
        end
        it 'shows a save confirmation message to the user' do
          post :create, qitem: sample_queue_item
          expect(flash[:success]).to be_present
        end
        it_behaves_like "redirect_to my_queue_path" do
          let(:action) { post :create, qitem: sample_queue_item }
        end
      end
    end
    context 'user not signed in' do
      it_behaves_like "require_logged_in_user" do
        let(:action) { post :create, qitem: sample_queue_item }
      end
    end
  end
end
