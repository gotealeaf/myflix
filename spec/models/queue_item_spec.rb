require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  it { should validate_presence_of(:video) }
  it { should validate_presence_of(:user) }

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
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.video_rating(user)).to be_nil
      end

      it 'returns rating from queue_item model if it exists' do
        queue_item = Fabricate(:queue_item, user: user, video: video, rating: 5)
        expect(queue_item.video_rating(user)).to eq(5)
      end

      it 'returns rating from the last review that the user gave for the video, if any exist and no rating exists in the queue_item object' do
        queue_item = Fabricate(:queue_item, user: user, video: video)
        review     = Fabricate(:review, creator: user, video: video)
        expect(queue_item.video_rating(user)).to eq(review.rating)
      end
    end

    describe '#video_category' do
      it 'returns the category from the related video' do
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.video_category).to eq(video.category)
      end
    end

    describe '::find_by_user_and_video' do
      it 'returns a QueueItem belonging to the provided user and video pair, if one exists' do
        expect(QueueItem.find_by_user_and_video(nil, video)).to be_nil
      end

      it 'returns nil if no QueueItem, which belongs to the provided user and video pair, exists' do
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(QueueItem.find_by_user_and_video(user, video)).to eq(queue_item)
      end
    end

    describe '::next_available_position' do
      it "returns a number that is one higher than the highest taken position in the given user's queue" do
        user              = Fabricate(:user)
        first_video       = Fabricate(:video)
        second_video      = Fabricate(:video)
        user.queue_items.create(video: first_video, position: 1)
        user.queue_items.create(video: second_video, position: 2)
        expect(QueueItem.next_available_position(user)).to eq(3)
      end
      it 'returns nil if the given user is invalid' do
        user              = Fabricate(:user)
        first_video       = Fabricate(:video)
        second_video      = Fabricate(:video)
        user.queue_items.create(video: first_video, position: 1)
        user.queue_items.create(video: second_video, position: 2)
        expect(QueueItem.next_available_position(nil)).to be_nil
      end
    end
  end
end
