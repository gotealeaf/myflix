require 'rails_helper'

describe QueueVideo do
  it { should belong_to :user }
  it { should belong_to :video }
  it { should validate_presence_of :position }
  it { should validate_numericality_of(:position).only_integer }

  describe '#video_name' do
    it 'should return the name of the associated video' do
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.video_name).to eq(video.name)
    end
  end
  describe '#rating' do
    it 'should return nil if the user has not reviewed the video' do
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.rating).to eq(nil)
    end
    it 'should return the associated rating given by the user' do
      review = Fabricate(:review, video: video, user: user, rating: 5)
      queue_video = Fabricate(:queue_video, video: video, user: user)
      expect(queue_video.rating).to eq(5)
    end
  end

  describe '#genre_name' do
    it 'should return the genre name of the associated video' do
      video = Fabricate(:video, genre: genre)
      queue_video = Fabricate(:queue_video, video: video)
      expect(queue_video.genre_name).to eq(genre.name.titleize)
    end
  end

  describe '#rating=' do
    context 'when rating by user is present' do
      let(:review) { Fabricate(:review, rating: 4, video: video, user: user) }
      let(:queue_video) { Fabricate(:queue_video, video: video, user: user) }

      it 'should update the rating if a new rating is given' do
        queue_video.rating = 1
        expect(Review.first.rating).to eq(1)
      end
      it 'should clear the rating if blank is selected' do
        queue_video.rating = nil
        expect(Review.first.rating).to eq(nil)
      end
    end
    context 'when rating by user is not present' do
      let(:queue_video) { Fabricate(:queue_video, video: video, user: user) }

      it 'should create a new rating by the user' do
        queue_video.rating = 4
        expect(Review.first.rating).to eq(4)
      end
      it 'should not create a new rating by user' do
        queue_video.rating = nil
        expect(Review.first.rating).to eq(nil)
      end
    end
  end
end
