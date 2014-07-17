require 'rails_helper'

describe User do
  it { should have_many(:reviews) }
  it { should have_many(:queue_videos).order(:position) }
  it { should have_secure_password }
  it { should validate_presence_of :username }
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation}
  it { should ensure_length_of(:password).is_at_least(8)}
  it { should validate_uniqueness_of :email }

  context '#video_in_queue?' do
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
end
