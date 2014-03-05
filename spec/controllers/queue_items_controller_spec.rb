require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'GET #index' do
    context 'with valid user' do
      let(:adam) { Fabricate(:user) }
      before do
        session[:user_id] = adam.id
      end
      it 'sets the @queue_items instance variable correctly' do
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        get :show
        expect(assigns(:queue_items)).to match_array([qitem, qitem2])
      end
      it 'renders the show template' do
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        get :show
        expect(response).to render_template(:show)
      end
    end
    context 'with invalid user' do
      it 'redirects user' do
        get :show
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user logged in' do
      let(:adam) { Fabricate(:user) }
      let(:monk) { Fabricate(:video) }
      before do
        session[:user_id] = adam.id
        Fabricate(:queue_item, user: adam, video: monk)
      end
      it 'redirects the user to the my queue page' do
        delete :destroy, id: QueueItem.first.id
        expect(response).to redirect_to my_queue_path
      end
      it 'deletes the video from the users queue' do
        delete :destroy, id: QueueItem.first.id
        expect(QueueItem.count).to eq(0)
      end
      it 'prevents a user from deleting another users queue item' do
        queue_item_2 = Fabricate(:queue_item, video: monk)
        delete :destroy, id: queue_item_2.id
        expect(QueueItem.count).to eq(2)
      end
      it 'displays an error if there is no queue item to delete' do
        queue_item_2 = Fabricate(:queue_item, video: monk)
        delete :destroy, id: queue_item_2.id
        expect(flash[:danger]).to be_present
      end
    end
    context 'user not logged in' do
      it 'redirects unauthenticated user to the login page' do
        queue_item_2 = Fabricate(:queue_item)
        delete :destroy, id: queue_item_2.id
      end
    end
  end

  describe 'POST #create' do
    let(:adam) { Fabricate :user }
    let(:monk) { Fabricate :video }
    let(:sample_queue_item) { Fabricate.attributes_for(:queue_item, user_id: adam.id, video_id: monk.id) }
    context 'user signed in' do
      before do
        session[:user_id] = adam.id
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
        it 'redirect the user to the the queue page' do
          expect(response).to redirect_to my_queue_path
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
        it 'redirects the user to the queue page' do
          post :create, qitem: sample_queue_item
          expect(response).to redirect_to my_queue_path
        end
      end
    end
    context 'user not signed in' do
      before do
        post :create, qitem: sample_queue_item
      end
      it 'displays and error message to the user' do
        expect(flash[:danger]).to be_present
      end
      it 'redirects the user to the login page' do
        expect(response).to redirect_to login_path
      end
    end
  end
end
