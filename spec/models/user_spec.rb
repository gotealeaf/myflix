require 'spec_helper'

describe User do
  it { should have_many(:reviews) }
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
end