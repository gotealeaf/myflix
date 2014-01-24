require 'spec_helper'

describe QueueItem do
  it { should validate_presence_of(:ranking) }
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe "rating handling" do
    it "should return review rating if present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, rating: 4, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.rating).to eq review.rating
    end
    it "should return 0 if no review rating" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.rating).to eq 0
    end
  end
end