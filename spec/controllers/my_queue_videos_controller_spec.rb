require 'rails_helper'

describe MyQueueVideosController do 
  let!(:user) { Fabricate(:user)}
  describe 'GET Index' do
    it "should set the correct video_queues attribute" do      
      login(user)
      2.times do
        video = Fabricate(:video)
        vq = Fabricate(:my_queue_video, video_id: video.id, user_id: user.id )
      end
      get :index
      assigns(:videos).size.should == 2      
    end

    it "should render the index template when login" do      
      login(user)
      get :index
      response.should render_template :index
    end

    it "should redirect to root path when not logged in" do
      get :index
      response.should redirect_to root_path
    end
  end

  describe 'POST Create' do
    it "should redirect to root path if not logged in" do
      post :create
      response.should redirect_to root_path
    end

    it "should create the my_queue_video object successfully when logged in" do      
      login(user)
      2.times do
        video = Fabricate(:video)        
      end
      post :create, video_id: 1
      expect(MyQueueVideo.count).to eq(1)
    end
  end

  describe 'DELETE Destroy' do
    it 'should delete the queue video when logged in' do
      login(user)
      2.times do
        video = Fabricate(:video)
        vq = Fabricate(:my_queue_video, video_id: video.id, user_id: user.id )
      end
      delete :destroy, id: 1
      expect(MyQueueVideo.count).to eq(1)
    end

    it 'should redirect to root path when not logged in' do
      delete :destroy, id: 1
      response.should redirect_to root_path
    end
  end
end