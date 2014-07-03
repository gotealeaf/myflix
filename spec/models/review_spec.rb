require 'rails_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:rating) }
  context "complete review flag set" do
    before { subject.stub(:complete_review) {true} }
    it { should validate_presence_of(:content) }
  end
  it { should validate_presence_of(:video) }
  it { should validate_presence_of(:user) }
  it { should validate_numericality_of(:rating).only_integer }
  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }

  context "average rating for video" do
    it "should return an average of all ratings for that video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      Fabricate(:review, video: video, rating: 2, user: user)
      Fabricate(:review, video: video, rating: 4, user: user)
      avg_rating = Review.average_rating_for_video(video)
      expect(avg_rating).to eq(3)
    end

    it "should return 0 if there are no reviews for that video" do
      video = Fabricate(:video)
      expect(Review.average_rating_for_video(video)).to eq(0)
    end
  end

  it "default order should be reverse chronological" do
    video = Fabricate(:video)
    user = Fabricate(:user)
    first_review = Fabricate(:review, video: video, user: user)
    second_review = Fabricate(:review, video: video, user: user, created_at: 1.day.ago)
    third_review = Fabricate(:review, video: video, user: user, created_at: 2.days.ago)
    expect(video.reviews).to eq([first_review, second_review, third_review])
  end
end
