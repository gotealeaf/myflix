require 'spec_helper'
require 'pry'

describe ReviewsController do
  describe 'POST #create' do
    context 'user signed in' do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it 'sets the @review object correct' do
        review1 = Fabricate.attributes_for(:review)
        post :create, review: review1
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'saves valid input' do
        review1 = Fabricate.attributes_for(:review)
        post :create, review: review1
        expect(Review.count).to eq(1)
      end

      it 'does not save valid input' do
        review1 = Fabricate.attributes_for(:review, content: nil, rating: nil)
        post :create, review: review1
        expect(Review.count).to eq(0)
      end

      it 'shows confirmation if save successful' do
        review1 = Fabricate.attributes_for(:review)
        post :create, review: review1
        expect(flash[:success]).to be_present
      end

      it 'shows failure message if save fails' do
        review1 = Fabricate.attributes_for(:review, content: nil, rating: nil)
        post :create, review: review1
        expect(flash[:danger]).to be_present
      end

      it 'renders videos#show page after save attempt successful' do
        review1 = Fabricate.attributes_for(:review)
        post :create, review: review1
        expect(response).to render_template 'videos/show'
      end
    end
    context 'no user signed in' do
      it 'prevents the user from saving' do
        review1 = Fabricate.attributes_for(:review, rating: nil)
        post :create, review: review1
        expect(Review.count).to eq(0)
      end
      it 'redirects the user to the home page' do
        review1 = Fabricate.attributes_for(:review, rating: nil)
        post :create, review: review1
        expect(response).to redirect_to login_path
      end
      it 'flashes correct message to user' do
        review1 = Fabricate.attributes_for(:review, rating: nil)
        post :create, review: review1
        expect(flash[:danger]).to be_present
      end
    end
  end
end
