require 'spec_helper'

describe VideosController do
  let(:video) { Fabricate(:video) }

  context "GET 'show'" do
    context "without signing in" do
      before(:each) do
        get "show", id: video.id
      end

      it "redirects to sign in page" do
        response.should redirect_to(sign_in_path)
      end

      it "will not set @video" do
        assigns(:video).should == nil
      end
    end

    context "signing in" do
      before(:each) do
        session[:user_id] = Fabricate(:user)
        get "show", id: video.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "sets @video" do
        assigns(:video).should == video
      end
    end
  end

  context "GET 'search'" do
    context "without signing in" do
      before(:each) do
        get "search", q: video.title
      end

      it "redirects to sign in page" do
        response.should redirect_to(sign_in_path)
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
        response.should be_success
      end

      it "sets @videos" do
        assigns(:videos).should == [video]
      end
    end
  end

end
