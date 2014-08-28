require "rails_helper"

describe QueueItemsController do
	describe "GET index" do
		it "sets the @queue_items to the queue items of the logged in user" do
			abby = Fabricate(:user)
			session[:user_id] = abby.id
			queue_item1 = Fabricate(:queue_item, user: abby)
			queue_item2 = Fabricate(:queue_item, user: abby)
			get :index
			expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
		end
		it "redirects to the sign in page for unathenticated users" do
			get :index
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "POST create" do
		it 'redirects to my queue page' do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(response).to redirect_to my_queue_path

		end

		it 'creates a queue item'
		it 'creates a queue item associated with the video'
		it 'creates a queue time associated with the current user'
		it 'puts the video as the last one in the queue'
		it 'does not add video if it is already in the queue'
		it 'redirects to the sign in page for an unathenticated user'

	end	
end