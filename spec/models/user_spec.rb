require 'spec_helper'

describe User do
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }
  
  describe "::reviews" do
    it "should return an empty array if user has no reviews" do
      user = Fabricate(:user)
      expect(user.reviews).to eq([])
    end
    it "should return the user's reviews if user has reviews" do
      user = Fabricate(:user)
      rev1 = Fabricate(:review, user: user, created_at: 1.day.ago)
      rev2 = Fabricate(:review, user: user, created_at: 30.seconds.ago)
      rev3 = Fabricate(:review, user: user, created_at: 3.days.ago)
      expect(user.reviews.length).to eq(3)
    end
    it "returns reviews in reverse chronological order" do
      user = Fabricate(:user)
      rev1 = Fabricate(:review, user: user, created_at: 2.days.ago)
      rev2 = Fabricate(:review, user: user, created_at: 1.day.ago)
      rev3 = Fabricate(:review, user: user, created_at: 3.days.ago)
      expect(user.reviews).to eq([rev2, rev1, rev3])
    end
  end

  describe "::queue_items" do
    let(:user) { Fabricate(:user) }
    let(:video1) { Fabricate(:video) }
    let(:video2) { Fabricate(:video) }
    let(:video3) { Fabricate(:video) }
    it "returns an empty array if no queue items" do
      expect(user.queue_items).to eq([])
    end 
    context "wiht multiple items" do 
      before do

      end
      it "returns an array with multiple items if queue has many items" do
        q1 = QueueItem.create(user: user, video: video1, position: 3)
        q2 = QueueItem.create(user: user, video: video2, position: 1)
        q3 = QueueItem.create(user: user, video: video3, position: 2)
        expect(user.queue_items).to match_array([q1, q2, q3])
      end
      it "returns the queue items, ordered by their position" do 
        q1 = QueueItem.create(user: user, video: video1, position: 3)
        q2 = QueueItem.create(user: user, video: video2, position: 1)
        q3 = QueueItem.create(user: user, video: video3, position: 2)
        expect(user.queue_items).to eq([q2, q3, q1])
      end
      it "returns the que items, ordered reverse chronologicaly, if two items of the same have the same position" do 
        q1 = QueueItem.create(user: user, video: video1, position: 2, created_at: 2.days.ago)
        q2 = QueueItem.create(user: user, video: video2, position: 2, created_at: 1.day.ago)
        expect(user.queue_items).to eq([q2, q1])
      end
    end
  end
end