require 'spec_helper'

describe ReviewsController do

  context "user logged in" do

    before do
      set_current_user
      @rick = current_user
      @monk = Fabricate(:video)
    end

    describe 'POST create with valid data' do
   
      before do
        post :create, review: {rating: 5, description: "great", user_id: @rick.id }, video_id: @monk.id
      end

      it "saves the record" do
        Review.count.should == 1
      end

      it "saves the record with the association to the video" do
        Review.first.video_id.should == @monk.id
      end

      it "saves the record with the association to the user" do
        Review.first.user_id.should == @rick.id
      end

      it "redirects to video" do
        response.should redirect_to @monk
      end

      it "sets the notice" do
        flash[:notice].should_not be_blank
      end

    end

    describe 'POST create with INVALID data' do
      
      before do
        post :create, review: {rating: nil, description: nil, user_id: @rick.id }, video_id: @monk.id
      end

      it "does NOT saves the record" do
        Review.count.should == 0
      end

      it "returns to video" do
        response.should redirect_to @monk
      end

      it "sets the error" do
        flash[:error].should_not be_blank
      end

    end

  end

  context "user NOT logged in" do
    describe 'POST create' do
      it_behaves_like "require_sign_in" do
        let(:action) {      post :create, review: {rating: 5, description: "great",  user_id: nil}, video_id: 1
}
      end
    end

  end

end



