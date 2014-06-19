require 'rails_helper'

describe QueueItemsController do

  context "signed in users" do

    describe "GET index" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        cookies[:auth_token] = user.auth_token
      end

      it "should assign the @queue_items variable for the signed in user" do
        qitem = Fabricate(:queue_item, video: video, user: user)
        qitem2 = Fabricate(:queue_item, video: video, user: user)
        get :index
        expect(assigns(:queue_items)).to match_array([qitem,qitem2])
      end
    end

    describe "POST create" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        cookies[:auth_token] = user.auth_token
      end

      it "should create a queue item from valid values" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "should set a flash success message when created" do
        post :create, video_id: video.id
        expect(flash[:success]).not_to be_blank
      end
      it "should redirect to my queue" do
        post :create, video_id: video.id
        expect(response).to redirect_to(my_queue_path)
      end
      it "should add a new queue item for the signed in user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(user)
      end
      it "should add a new queue item for the video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "puts the video as the last one in the queue" do
        Fabricate(:queue_item, user: user)
        superman = Fabricate(:video)
        post :create, video_id: superman.id
        super_queue_item = QueueItem.where(video:superman,user:user).first
        expect(super_queue_item.position).to eq(2)
      end
      it "does not add the video if the video is already in the queue" do
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video.id
        expect(user.queue_items.count).to eq(1)
      end
      it "should set a flash info message if the video is already in the user queue" do
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video.id
        expect(flash[:info]).not_to be_blank
      end
    end

  end

  context "users who are NOT signed in" do
    describe "GET index" do
      it "should redirect to the sign_in page" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
    describe "POST create" do
      it "should redirect to sign_in page" do
        post :create
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end
