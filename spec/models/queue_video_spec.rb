require 'rails_helper'

describe QueueVideo do
  it { should belong_to :user }
  it { should belong_to :video }
  it { should validate_presence_of :position }
  it { should validate_numericality_of(:position).only_integer }

  describe '#video_name' do
    it 'should return the name of the associated video' do
      video = Fabricate(:video)
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.video_name).to eq(video.name)
    end
  end
  describe '#rating' do
    it 'should return nil if the user has not reviewed the video' do
      video = Fabricate(:video)
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.rating).to eq(nil)
    end
    it 'should return the associated rating given by the user' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 5)
      queue_video = Fabricate(:queue_video, video: video, user: user)
      expect(queue_video.rating).to eq(5)
    end
  end

  describe '#genre_name' do
    it 'should return the genre name of the associated video' do
      genre = Fabricate(:genre)
      video = Fabricate(:video, genre: genre)
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.genre_name).to eq(genre.name)
    end
  end
end
