require 'rails_helper'

describe MyQueueVideosController do 
  let!(:user) { Fabricate(:user)}
  describe 'GET Index' do
    it "should set the correct video_queues attribute" do      
      login(user)
      2.times do
        video = Fabricate(:video)
        vq = Fabricate(:my_queue_video, video: video, user: user )
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

  describe 'POST Update_queue_videos' do
    let!(:user) { Fabricate(:user)}
    let(:video1) { Fabricate(:video)}
    let(:video2) { Fabricate(:video)}
    let(:q1) { Fabricate(:my_queue_video, user: user, video: video1, index: 1)}
    let(:q2) { Fabricate(:my_queue_video, user: user, video: video2, index: 2)}
    context 'with valid inputs' do
      before do
        login(user)    
      end      
      it 'should redirect to queue path after update succesfully' do
        post :update_queue_videos
        expect(response).to redirect_to my_queue_videos_path
      end
      it 'should update the index order of the videos correctly' do        
        post :update_queue_videos, video: [{id: video1.id, index: 2}, {id: video2.id, index: 1} ]
        expect(user.my_queue_videos).to eq([q2, q1])
      end
    end
    context 'with invalid inputs'
    context 'update as a non-owner'
  end
end