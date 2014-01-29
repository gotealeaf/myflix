require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :full_name }
  it { should have_secure_password }
  it { should validate_presence_of :password }
  it { should have_many :reviews }
  it { should have_many :queue_items }

  describe '#next_available_position' do
    it 'returns a number that is one higher than the highest taken position' do
      user = Fabricate(:user)
      first_video = Fabricate(:video)
      second_video = Fabricate(:video)
      user.queue_items.create(video: first_video, position: 1)
      user.queue_items.create(video: second_video, position: 2)
      expect(user.next_available_position).to eq(3)
    end
  end

  describe '#queued_videos' do
    it 'returns an empty array if no videos are queued' do
      user = Fabricate(:user)
      expect(user.queued_videos).to eq([])
    end

    it 'returns an array of all videos queued by current user' do
      user = Fabricate(:user)
      first_video = Fabricate(:video)
      second_video = Fabricate(:video)
      user.queue_items.create(video: first_video, position: 1)
      user.queue_items.create(video: second_video, position: 2)
      expect(user.queued_videos).to match_array([first_video, second_video])
    end
  end
end
