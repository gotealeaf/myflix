require 'spec_helper'

describe ReviewsController do

  context "user logged in" do

    before do
      @rick = Fabricate(:user)
      session[:user_id] = @rick.id
      @monk = Fabricate(:video)
    end

    describe 'POST create with valid data' do
      it "renders redirect to sign_in" do
        post :create, review: {rating: 5, description: "great", video_id: @monk.id,  user_id: @rick.id }
        response.should redirect_to video_path(@monk.id)
      end
    end


  end

  context "user NOT logged in" do

    before do
      @monk = Fabricate(:video)
      post :create, review: {rating: 5, description: "great",  user_id: nil, video: @monk}
    end

    describe 'POST create' do
      it "renders redirect to sign_in" do
        response.should redirect_to sign_in_path
      end
    end

  end

end
