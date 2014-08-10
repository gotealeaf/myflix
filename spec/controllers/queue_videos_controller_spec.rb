require 'rails_helper'

describe QueueVideosController do
  describe 'GET Index' do

    it 'should assign @queue_videos variable for authenticated users' do
      set_session_user
      queue_video1 = Fabricate(:queue_video, user: user)
      queue_video2 = Fabricate(:queue_video, video_id: 2, user: user)
      get :index
      expect(assigns(:queue_videos)).to match_array([queue_video1, queue_video2])
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :index }
    end
  end

  describe 'POST Create' do
    context 'when user is authenticated' do

      before { set_session_user }

      it_behaves_like 'redirect for authenticated user' do
        let(:action) { post :create, video_id: video.id }
      end
      it 'should create a queue video' do
        post :create, video_id: video.id
        expect(QueueVideo.count).to eq(1)
      end
      it 'should associate queue item to current user' do
        post :create, video_id: video.id
        expect(QueueVideo.first.user).to eq(user)
      end
      it 'should associate queue video to a video' do
        post :create, video_id: video.id
        expect(QueueVideo.first.video).to eq(video)
      end
      it 'should place the queue video at the bottom of the list' do
        Fabricate(:queue_video, video: video, user: user, position: 1)
        video_2 = Fabricate(:video)
        post :create, video_id: video_2.id
        video_2_position = QueueVideo.find_by(video_id: video_2.id).position
        expect(video_2_position).to eq(2)
      end
      it 'should not add video if already in queue' do
        Fabricate(:queue_video, video: video, user: user)
        post :create, video_id: video.id
        expect(QueueVideo.count).to eq(1)
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { post :create, video_id: video.id }
    end

  end

  describe 'DELETE Destroy' do
    context 'when user is authenticated' do

      let(:queue_video) { Fabricate(:queue_video, video: video, user: user) }
      before { set_session_user }

      it_behaves_like 'redirect for authenticated user' do
        let(:action) { delete :destroy, id: queue_video.id }
      end
      it 'should delete selected video from queue' do
        delete :destroy, id: queue_video.id
        expect(QueueVideo.count).to eq(0)
      end
      it 'should not delete video from queue if not the users queue' do
        other_user = Fabricate(:user)
        queue_video = Fabricate(:queue_video, user: other_user, video: video)
        delete :destroy, id: queue_video.id
        expect(QueueVideo.count).to eq(1)
      end
      it 'should normalise the position numbers' do
        queue_video_1 = Fabricate(:queue_video, position: 1, user: user, video: video)
        queue_video_2 = Fabricate(:queue_video, position: 2, user: user, video: video)
        queue_video_3 = Fabricate(:queue_video, position: 3, user: user, video: video)
        delete :destroy, id: queue_video_1.id
        expect(QueueVideo.find(queue_video_2.id).position).to eq(1)
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:queue_video) { Fabricate(:queue_video) }
      let(:action) { delete :destroy, id: queue_video.id }
    end
  end

  describe 'POST update_queue' do
    context 'when user is authenticated' do

      let(:video_1) { Fabricate(:video) }
      let(:video_2) { Fabricate(:video) }
      before { set_session_user}

      context 'if user updates positions' do

        before do
          @queue_video_1 = Fabricate(:queue_video, position: 1, user: user, video: video_1)
          @queue_video_2 = Fabricate(:queue_video, position: 2, user: user, video: video_2)
        end

        it_behaves_like 'redirect for authenticated user' do
          let(:action) { post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2}, {id: @queue_video_2.id, position: 1}] }
        end
        it 'should update the position of queue videos' do
          post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2}, {id: @queue_video_2.id, position: 1}]
          expect(user.queue_videos).to eq([@queue_video_2, @queue_video_1])
        end
        it 'should normalise the position numbers' do
          post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 3 }]
          expect(user.queue_videos.map(&:position)).to eq([1,2])
        end

        context 'with invalid non integer inputs' do
          it_behaves_like 'redirect for authenticated user' do
            let(:action) { post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2.5}, {id: @queue_video_2.id, position: 1}] }
          end
          it 'should flash an error message' do
            post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2.5}, {id: @queue_video_2.id, position: 1}]
            expect(flash[:danger]).to be_present
          end
          it 'should not update the position of queue videos' do
            post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 3}, {id: @queue_video_2.id, position: 2.5}]
            expect(@queue_video_1.reload.position).to eq(1)
          end
        end
      end

      context 'if rating is blank' do
        it 'should create new rating if user selects a rating' do
          queue_video = Fabricate(:queue_video, video: video, user: user)
          post :update_queue, queue_videos: [{id: queue_video.id, position: 1, rating: 4}]
          expect(QueueVideo.first.rating).to eq(4)
        end
        it 'should not create new rating if rating is blank' do
        queue_video = Fabricate(:queue_video, video: video, user: user)
        post :update_queue, queue_videos: [{id: queue_video.id, position: 1, rating: ""}]
        expect(QueueVideo.first.rating).to be_blank
        end
      end

      context 'if rating is not blank' do
        it 'should update rating' do
          review = Fabricate(:review, rating: 1, user: user, video: video)
          queue_video = Fabricate(:queue_video, video: video, user: user)
          post :update_queue, queue_videos: [{id: queue_video.id, position: 1, rating: 4}]
          expect(QueueVideo.first.rating).to eq(4)
        end
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { post :update_queue }
    end
  end
end
