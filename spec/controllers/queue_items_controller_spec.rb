require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'POST #create' do
    context 'invalid user' do
      it 'redirects user to login_path' do
        post :create
        expect(response).to redirect_to login_path
      end
      it 'displays error message to user'
    end
    context 'signed in user' do
      before do
        @user = Fabricate(:user)
        @video = Fabricate(:video)
        @qitem = Fabricate.attributes_for(:queue_item, position: 1, video: @video, user_id: nil)
        session[:user_id] = @user.id
      end

      context 'assignment validation' do
        before do
          post :create, qitem: @qitem
        end
        it 'sets the QueueItem object correctly based on params' do
          expect(assigns(:qitem)).to be_instance_of(QueueItem)
        end
        it 'assigns the user_id correctly' do
          expect(assigns(:qitem).user_id).to eq(session[:user_id])
        end
        it 'assigns the video_id correctly' do
          expect(assigns(:qitem).video_id).to eq(@video.id)
        end
      end

      context 'already in queue' do
        before do
          qitem2 = Fabricate(:queue_item, position: 1, user_id: @user.id, video_id: @video.id)
          post :create, qitem: @qitem
        end
        it 'checks if item is already in queue' do
          expect(assigns(:exist)).to eq(true)
        end
        it 'shows error message' do
          expect(flash[:danger]).to be_present
        end
        it 'redirects user to queue page' do
          expect(response).to redirect_to queue_items_path
        end
      end

      context 'position set' do
        before do
          qitem2 = Fabricate(:queue_item, position: 2, video_id: @video.id, user_id: @user.id)
        end

        it 'checks if the same position is set' do
          qitem3 = Fabricate.attributes_for(:queue_item, position: 2, video_id: @video.id, user_id: @user.id)
          post :create, qitem: qitem3
          expect(assigns(:same_position)).to eq(true)
        end

        it 'updates position if different' do
          qitem3 = Fabricate.attributes_for(:queue_item, position: 3, video_id: @video.id, user_id: @user.id)
          post :create, qitem: qitem3
          expect(QueueItem.first.position).to eq(qitem3[:position])
        end
      end

      context 'if no position is set' do
        it 'sets position to number after last allocated'
      end

      context 'other video already in that position' do
        it 'moves all other videos down 1 step'
        it 'sets video position as specified by user'
      end

      context 'save success' do
        it 'sucessfully updates QueueItem'
        it 'redirects user to queue_item_path'
        it 'shows positive confirmation'
      end

      context 'if not already in queue' do
        before do
          10.times do Fabricate(:queue_item) end
          post :create, qitem: @qitem
        end
        it 'redirects to queue_items_path' do
          expect(assigns(:exist)).to eq(false)
        end
      end

      context 'invalid params' do
        it 'fails to save QueueItem'
        it 'redirects user to video_show_path'
        it 'shows error message'
      end
    end
  end
end
