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

		it 'creates a queue item' do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.count).to eq(1)
		end

		it 'creates a queue item associated with the video' do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.first.video).to eq(video)
		end
		it 'creates a queue time associated with the current user' do
			abby = Fabricate(:user)
			session[:user_id] = abby.id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.first.user).to eq(abby)
		end
		it 'puts the video as the last one in the queue' do
			abby = Fabricate(:user)
			session[:user_id] = abby.id
			vikings = Fabricate(:video)
			Fabricate(:queue_item, video: vikings, user: abby)
			stargate = Fabricate(:video)
			post :create, video_id: stargate.id
			stargate_queue_item = QueueItem.where(video_id: stargate.id, user_id: abby.id).first
			expect(stargate_queue_item.position).to eq(2)
		end
		it 'does not add video if it is already in the queue' do
			abby = Fabricate(:user)
			session[:user_id] = abby.id
			vikings = Fabricate(:video)
			Fabricate(:queue_item, video: vikings, user: abby)
			post :create, video_id: vikings.id
			expect(abby.queue_items.count).to eq(1)
		end
		it 'redirects to the sign in page for an unathenticated user' do
			post :create, video_id: 3
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "DELETE destroy" do
		it 'redirects to the queue page' do
			session[:user_id] = Fabricate(:user).id
			queue_item = Fabricate(:queue_item)
			delete :destroy, id: queue_item.id
			expect(response).to redirect_to queue_item_path
		end		
		it 'deletes the queue item' do
			abby = Fabricate(:user)
			session[:user_id] = abby.id
			queue_item = Fabricate(:queue_item, user: abby)
			delete :destroy, id: queue_item.id
			expect(QueueItem.count).to eq(0)
		end
		it 'does not delete the queue item if it does not belong to the current user' do
			abby = Fabricate(:user)
			seth = Fabricate(:user)
			session[:user_id] = abby.id
			queue_item = Fabricate(:queue_item, user: seth)
			delete :destroy, id: queue_item.id
			expect(QueueItem.count).to eq(1)
		end
		it 'redirects to the sign in page for unauthenticated users' do
			delete :destroy, id: 3
			expect(response).to redirect_to sign_in_path
		end
	end




end