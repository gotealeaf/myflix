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
end