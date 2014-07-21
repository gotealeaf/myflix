require 'rails_helper'

describe Following do
  it { should belong_to(:user) }
  it { should belong_to(:followee).class_name "User"}

  describe '#full_name' do
    it 'should return followees full name when called' do
      followee = Fabricate(:user)
      following = Fabricate(:following, user: user, followee: followee)
      expect(following.full_name).to eq(followee.full_name)
    end
  end

  describe '#email' do
    it 'should return followees email when called' do
      followee = Fabricate(:user)
      following = Fabricate(:following, user: user, followee: followee)
      expect(following.email).to eq(followee.email)
    end
  end

  describe '#count_queue_videos' do
    it 'should return 0 if there are no videos in the followees queue' do
      followee = Fabricate(:user)
      following = Fabricate(:following, user: user, followee: followee)
      expect(following.count_queue_videos).to eq(0)
    end
    it 'should return the number of videos in the followees queue' do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      followee = Fabricate(:user)
      following = Fabricate(:following, user: user, followee: followee)
      Fabricate(:queue_video, user: user, video: video1)
      Fabricate(:queue_video, user: followee, video: video1)
      Fabricate(:queue_video, user: followee, video: video2)
      expect(following.count_queue_videos).to eq(2)
    end
  end

  describe '#count_followers' do
    it 'should return 0 if no one is following the followee' do
      followee = Fabricate(:user)
      following = Fabricate(:following, user: user, followee: user)
      expect(following.count_queue_videos).to eq(0)
    end
    it 'should return the number of people following the followee' do
      followee = Fabricate(:user)
      follower = Fabricate(:user)
      Fabricate(:following, user: follower, followee: followee)
      following = Fabricate(:following, user: user, followee: followee)
      expect(following.count_followers).to eq(2)
    end
  end
 end
