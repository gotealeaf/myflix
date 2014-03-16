require 'spec_helper'

describe VideosController do
  let(:video) { Fabricate(:video) }

  context "GET 'show'" do
    context "without signing in" do
      before(:each) do
        get "show", id: video.id
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "will not set @video" do
        expect(assigns(:video)).to be_nil
      end

      it "will not set @reviews" do
        assigns(:reveiws).should be_nil
      end
    end

    context "signed in" do
      before(:each) do
        session[:user_id] = Fabricate(:user)
        get "show", id: video.id
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "sets @video" do
        expect(assigns(:video)).to eq(video)
      end

      it "@review ordered by created_at DESC" do
        review_1 = Fabricate(:review, video: video, created_at: 2.day.ago)
        review_2 = Fabricate(:review, video: video, created_at: 1.day.ago)
        expect(assigns(:reviews)).should eq([review_2, review_1])
      end
    end
  end

  context "GET 'search'" do
    context "not signed in" do
      before(:each) do
        get "search", q: video.title
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "will not set @videos" do
        assigns(:videos).should == nil
      end
    end

    context "signing in" do
      before(:each) do
        session[:user_id] = Fabricate(:user).id
        get "search", q: video.title
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "sets @videos" do
        expect(assigns(:videos)).should eq([video])
      end
    end
  end

end
