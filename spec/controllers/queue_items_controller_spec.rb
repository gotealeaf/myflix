require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    
    let(:jane) { Fabricate(:user) } 
    let(:queue_item1) { Fabricate(:queue_item, user: jane) }
    let(:queue_item2) { Fabricate(:queue_item, user: jane) }
    
    it "should set the @queue_items instance variable for an authenticated user" do
      session[:user_id] = jane.id
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to root path if user is not authenticated" do
      get :index
      expect(response).to redirect_to root_path
    end
  end #ends GET index
  
  describe "POST create" do
    let(:jane) { Fabricate(:user) } 
    let(:video) { Fabricate(:video) } 
    
    it 'should redirect to the my queue page' do
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
  
    it 'should add a video when a signed in user clicks add to queue' do
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    
    it 'should create a queue item associated with the right video' do
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    
    it 'should create a queue item associated with the right user' do
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(QueueItem.first.user). to eq(jane)
    end
    
    it 'should display a success message if video is successfully added to the queue' do
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(flash[:success]).not_to be_blank
    end
    
    it 'should put the added video as the last one in the existing queue' 
    it 'should not add a duplicate video if existing video title is already in the queue'
    it 'should display an error message if the video could not be added to the queue' do
      # add another condition here
      session[:user_id] = jane.id
      post :create, video_id: video.id
      expect(flash[:danger]).not_to be_blank
    end
  
    it 'should not add a video if the user is not signed in' do
      post :create
      expect(QueueItem.count).to eq(0) 
    end
    
    it 'should redirect the user back to root path if not signed in' do
      post :create
      expect(response).to redirect_to root_path
    end
    
    it 'should display an error message if user not signed in'
  end
end