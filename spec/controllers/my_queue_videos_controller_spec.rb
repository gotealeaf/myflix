require 'rails_helper'

describe MyQueueVideosController do 
  describe 'GET Index' do
    it "should set the correct video_queues attribute" do
      user = Fabricate(:user)
      login(user)
      2.times do
        video = Fabricate(:video)
        vq = Fabricate(:my_queue_video, video_id: video.id, user_id: user.id )
      end
      get 'index'
      assigns(:videos).size.should == 2
      

    end

    it "should render the index template when login" do
      user = Fabricate(:user)
      login(user)
      get 'index'
      response.should render_template :index
    end

    it "should redirect to root path when not logged in" do
      get 'index'
      response.should redirect_to root_path
    end
  end
end