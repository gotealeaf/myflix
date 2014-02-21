require 'spec_helper'
require 'pry'

describe ReviewsController do
  describe 'POST #create' do
    context 'user signed in' do
      context 'with valid input'
      before do
        @video = Fabricate(:video)
        request.env["HTTP_REFERER"] = video_path(@video.id)
        session[:user_id] = Fabricate(:user).id
        @review_valid = Fabricate.attributes_for(:review)
        post :create, video_id: @video.id, review: @review_valid
      end
      it 'sets the @review object correct' do
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'saves valid input' do
        expect(Review.count).to eq(1)
      end

      it 'assigns the user_id correctly' do
        expect(assigns(:review).video_id).to eq(@video.id)
      end

      it 'assigns the video_id correctly' do
        expect(assigns(:review).user_id).to eq(session[:user_id])
      end

      it 'shows confirmation if save successful' do
        expect(flash[:success]).to be_present
      end

      it 'renders videos#show page after save attempt successful' do
        expect(response).to redirect_to video_path(@video.id)
      end
    end
    context 'without valid input' do
      before do
        @video = Fabricate(:video)
        request.env["HTTP_REFERER"] = video_path(@video.id)
        @review_invalid = Fabricate.attributes_for(:review, rating: nil)
        post :create, video_id: @video.id, review: @review_invalid
      end
      it 'does not save invalid input' do
        expect(Review.count).to eq(0)
      end

      it 'shows failure message if save fails' do
        expect(flash[:danger]).to be_present
      end
    end
  end
  context 'no user signed in' do
    before do
      @video = Fabricate(:video)
      request.env["HTTP_REFERER"] = video_path(@video.id)
      session[:user_id] = nil
      @review_valid = Fabricate.attributes_for(:review)
      post :create, video_id: @video.id, review: @review_valid
    end
    it 'prevents the user from saving' do
      expect(Review.count).to eq(0)
    end
    it 'redirects the user to the home page' do
      expect(response).to redirect_to login_path
    end
    it 'flashes correct message to user' do
      expect(flash[:danger]).to be_present
    end
  end
end
