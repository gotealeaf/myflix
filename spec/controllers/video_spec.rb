require 'spec_helper'

describe VideosController do

		describe "GET show" do
			it "assigns @video to params[:id] if user authenticated" do
				session[:user_id] = Fabricate(:user).id
				video = Fabricate(:video)
				get :show, id: video.id
				expect(assigns(:video)).to eq(video)
			end

			it "assigns @review if user authenticated" do
				session[:user_id] = Fabricate(:user).id
				video = Fabricate(:video)
				review1 = Fabricate(:review, video:video)
				review2 = Fabricate(:review, video:video)
				get :show, id: video.id
				expect(assigns(:review)).to match_array([review1, review2])
			end


			it "redirects if user not authenticated" do
				video = Fabricate(:video)
				get :show, id: "1"
				expect(response).to redirect_to root_path
			end
		end

		describe "GET searchresults" do
			it "assigns @videoes based on search results if user authenticated" do
				session[:user_id] = Fabricate(:user).id
				video = Fabricate(:video)
				get :searchresults, query: video.title
				expect(assigns(:videos)).to eq([video])
			end

			it "redirects if user not authenticated" do
				video = Fabricate(:video)
				get :searchresults, query: video.title
				expect(response).to redirect_to root_path
			end
		end

	
end