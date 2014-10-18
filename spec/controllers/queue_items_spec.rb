require 'spec_helper'

describe QueueItemsController do
	describe "GET index" do
		context "user authenticated" do
			it "sets @queue_items object" do
				user = Fabricate(:user)
				session[:user_id] = user.id
				queueitem1 = Fabricate(:queue_item, user_id: user.id)
				queueitem2 = Fabricate(:queue_item, user_id: user.id)
				get :index
				expect(assigns(:queue_items)).to match_array([queueitem1, queueitem2])
			end

			it "should display all the queue items in order" do
				user = Fabricate(:user)
				session[:user_id] = user.id
				queueitem1 = Fabricate(:queue_item, user_id: user.id, position: "2")
				queueitem2 = Fabricate(:queue_item, user_id: user.id, position: "1")
				get :index
				expect(assigns(:queue_items)).to eq([queueitem2, queueitem1])
			end
		end

		context "user not authenticated" do
			it "should redirect to xxx if user not authenticated" do
				queueitem1 = Fabricate(:queue_item)
				get :index
				expect(response).to redirect_to root_path
			end
		end

	end

	describe "POST create" do
		context "user authenticated" do
				let(:user) {Fabricate(:user)}
				let(:video) {Fabricate(:video)}
			
			it "adds a queue item to the queue" do
				session[:user_id] = user.id
				post :create
				expect(QueueItem.count).to eq(1)
			end
			it "add a queue_item to user's queue" do	
				session[:user_id] = user.id
				post :create
				expect(QueueItem.first.user).to eq(user)
			end

			it "adds current video as the queue_item" do
				session[:user_id] = user.id
				post :create, video_id: video.id
				expect(QueueItem.first.video).to eq(video)
			end

			it "added queue item is last on the list" do
				session[:user_id] = user.id
				queueitem1 = Fabricate(:queue_item, user_id: user.id, position: "2")
				queueitem2 = Fabricate(:queue_item, user_id: user.id, position: "1")
				post :create, video_id: video.id
				expect(QueueItem.find(3).position).to eq(3)
			end

			it "does not add a queue item if video is already on the list" do
				session[:user_id] = user.id
				queueitem1 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: "1")
				post :create, video_id: video.id
				expect(user.queue_items.count).to eq(1)
			end

			it "redirects to GET my_queue" do
				session[:user_id] = user.id
				post :create, video_id: video.id
				expect(response).to redirect_to my_queue_path
			end
		end

		context "user not authenticated" do
			it "should redirect to signin path" do
				video = Fabricate(:video)
				post :create, video_id: video.id
				expect(response).to redirect_to root_path
			end
		end
	end

	describe "DELETE destroy" do
		it "should destroy the queue item" do
				user = Fabricate(:user)
				video = Fabricate(:video)
				session[:user_id] = "1"
				queueitem1 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: "1")
				delete :destroy, id: queueitem1.id
				expect(QueueItem.count).to eq(0)
		end
=begin
		it "should increase position of all queue items below it" do
				user = Fabricate(:user)
				video = Fabricate(:video)
				session[:user_id] = user.id
				queueitem1 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: 1)
				queueitem2 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: 2)
				queueitem3 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: 3)
				delete :destroy, id: queueitem2.id
				expect(queueitem3.position).to eq(2)
		end
=end
		it "should not destroy if queue item is not in users queue" do
				user1 = Fabricate(:user)
				user2 = Fabricate(:user)
				video = Fabricate(:video)
				session[:user_id] = user1.id
				queueitem1 = Fabricate(:queue_item, user_id: user2.id, video_id: video.id, position: 1)
				delete :destroy, id: queueitem1.id
				expect(QueueItem.count).to eq(1)
		end


		it "should redirect_to my queue page" do
				user = Fabricate(:user)
				video = Fabricate(:video)
				session[:user_id] = "1"
				queueitem1 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: "1")
				delete :destroy, id: queueitem1.id
				expect(response).to redirect_to my_queue_path
		end

		it "should redirect to signin path if user not authenticated" do
				user = Fabricate(:user)
				video = Fabricate(:video)
				queueitem1 = Fabricate(:queue_item, user_id: user.id, video_id: video.id, position: 1)
				delete :destroy, id: queueitem1.id
				expect(response).to redirect_to root_path
		end

	end
end