require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }

  context do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    describe '#video_title' do
      it 'returns the title of the related video' do
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.video_title).to eq(video.title)
      end
    end

    describe '#video_rating' do
      it 'returns nil if there is no rating and no review' do
        queue_item =  Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.video_rating(user)).to be_nil
      end

      it 'returns rating from queue_item model if it exists' do
        queue_item = Fabricate(:queue_item, user: user, video: video, rating: 5)
        expect(queue_item.video_rating(user)).to eq(5)
      end

      it 'returns rating from the last review that the user gave for the video, if any exist and no rating exists in the queue_item object' do
        queue_item =  Fabricate(:queue_item, user: user, video: video)
        review = Fabricate(:review, creator: user, video: video)
        expect(queue_item.video_rating(user)).to eq(review.rating)
      end
    end

    describe '#video_category' do
      it 'returns the category from the related video' do
        queue_item =  Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.video_category).to eq(video.category)
      end
    end
  end
end
