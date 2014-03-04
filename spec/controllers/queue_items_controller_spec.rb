require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'GET #index' do
    context 'with valid user' do
      it 'sets the @queue_items instance variable correctly' do
        adam = Fabricate(:user)
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        session[:user_id] = adam.id
        get :show
        expect(assigns(:queue_items)).to match_array([qitem, qitem2])
      end

      it 'renders the show template' do
        adam = Fabricate(:user)
        qitem = Fabricate(:queue_item, user: adam)
        qitem2 = Fabricate(:queue_item, user: adam)
        session[:user_id] = adam.id
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

  describe 'POST #create' do
    context 'user signed in' do
      let(:adam) { Fabricate :user }
      let(:monk) { Fabricate :video }
      # let(:monk_queue_item) { Fabricate :queue_item, user: adam, video: monk }
      context 'the video is already in the queue' do
        it 'fails to save the video to the queue' do
          # adam = Fabricate(:user)
          session[:user_id] = adam.id
          # monk = Fabricate(:video)
          # monk_queue_item = Fabricate(:queue_item, user: adam, video: monk)
          sample_queue_item = Fabricate.attributes_for(:queue_item, user: adam, video: monk)
          post :create, qitem: sample_queue_item
          expect(QueueItem.count).to eq(1)
        end
        it 'shows a error message to the user' do

        end
        it 'redirect the user to the the queue page'
      end

      context 'the video is not already in the queue' do
        it 'saves the video to the queue'
        it 'adds the queue to the back of the queue'
        it 'shows a save confirmation message to the user'
        it 'redirects the user to the queue page'
      end
    end
    context 'user not signed in' do
      it 'displays and error message to the user'
      it 'redirects the user to the login page'
    end
  end
end
