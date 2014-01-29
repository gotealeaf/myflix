require 'spec_helper'

describe VideosController do
  describe 'GET #show' do
    it 'sets the @video variable when a video is found using the provided id for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video             = Fabricate(:video)
      get :show, id: video
      expect(assigns(:video)).to eq(video)
    end

    it 'redirects to the sign in page for unauthorized users' do
      video = Fabricate(:video)
      get :show, id: video
      expect(response).to redirect_to sign_in_path
    end

    it 'sets @review' do
      session[:user_id] = Fabricate(:user).id
      video             = Fabricate(:video)
      get :show, id: video
      expect(assigns(:review)).to be_instance_of(Review)
    end

    it 'creates an empty review' do
      session[:user_id] = Fabricate(:user).id
      video             = Fabricate(:video)
      get :show, id: video
      expect(assigns(:review)).to be_new_record
    end
  end

  describe 'POST #search' do
    it 'sets @videos to an array of the matching videos for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video             = Fabricate(:video, title: 'Sons of anarchy')
      post :search, search_string: 'anarchy'
      expect(assigns(:videos)).to eq([video])
    end

    it 'redirects unauthorized users to the sign in page' do
      Fabricate(:video, title: 'Sons of anarchy')
      post :search, search_string: 'anarchy'
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'POST #queue' do
    let(:video) { Fabricate(:video) }

    context 'authorized user' do
      let(:user) { Fabricate(:user) }

      before do
        session[:user_id]           = user.id
        request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
        post :queue, id: video.id

      end

      it 'adds video to current users queue' do
        expect(user.queued_videos).to eq([video])
      end

      it 'redirects to previous page' do
        expect(response).to redirect_to(request.env["HTTP_REFERER"])
      end

      it 'sets success message' do
        expect(flash[:success]).not_to be_blank
      end

      it 'assigns position automatically' do
        another_video = Fabricate(:video)
        post :queue, id: another_video.id
        expect(user.next_available_position).to eq (3)
      end

      it 'does not add the video twice' do
        post :queue, id: video.id
        expect(user.queued_videos).to eq([video])
      end
    end

    context 'unauthorized user' do
      it 'redirects to sign in page' do
        post :queue, id: video.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'POST #dequeue' do
    let(:video) { Fabricate(:video) }

    context 'authorized user' do
      let(:user) { Fabricate(:user) }

      before do
        session[:user_id]           = user.id
        request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
        Fabricate(:queue_item, video: video, user: user)
        post :dequeue, id: video.id
      end

      it 'removes video from current users queue' do
        expect(user.queue_items).to eq([])
      end

      it 'does not remove video from database' do
        expect(Video.all).to eq([video])
      end

      it 'redirects to previous page' do
        expect(response).to redirect_to(request.env["HTTP_REFERER"])
      end

      it 'sets success message' do
        expect(flash[:success]).not_to be_blank
      end
    end

    context 'unauthorized user' do
      it 'redirects to sign in page' do
        video = Fabricate(:video)
        post :dequeue, id: video.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
