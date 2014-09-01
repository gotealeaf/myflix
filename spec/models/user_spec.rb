require 'rails_helper'

describe User do
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should have_many(:queue_videos).order(:position) }
  it { should have_many(:user_tokens) }
  it { should have_secure_password }
  it { should validate_presence_of :username }
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation}
  it { should ensure_length_of(:password).is_at_least(8)}
  it { should validate_uniqueness_of :email }

  describe '#video_in_queue?' do
    it 'returns true if the video is in users queue_videos' do
      Fabricate(:queue_video, video: video, user: user)
      expect(user.video_in_queue?(video)).to be true
    end

    it 'returns false if the video is not in queue_videos' do
      other_user = Fabricate(:user)
      Fabricate(:queue_video, video: video, user: other_user)
      expect(user.video_in_queue?(video)).to be false
    end
  end

  describe '#count_queue_videos' do
    it 'returns 0 if there are no videos in the users queue' do
      expect(user.count_queue_videos).to eq(0)
    end
    it 'returns the total number of videos in a users queue' do
      queue_video1 = Fabricate(:queue_video, user: user, video_id: 1)
      queue_video2 = Fabricate(:queue_video, user: user, video_id: 2)
      expect(user.count_queue_videos).to eq(2)
    end
  end

  describe '#count_reviews' do
    it 'returns 0 if user has not posted any reviews' do
      expect(user.count_reviews).to eq(0)
    end
    it 'returns the total number of reviews that user has posted' do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      Fabricate(:review, user: user, video: video1)
      Fabricate(:review, user: user, video: video2)
      expect(user.count_reviews).to eq(2)
    end
  end

  describe '#deactivate!' do
    it 'sets the user status to inactive' do
      nelle = Fabricate(:user)
      nelle.deactivate!
      expect(nelle).not_to be_active
    end
  end
end
