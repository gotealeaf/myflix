require 'rails_helper'

describe VideoDecorator do
  describe '#avg_rating' do
    it "returns 'no ratings available' when there are no ratings" do
      expect(VideoDecorator.new(Fabricate(:video)).avg_rating).to eq('no ratings available')
    end
    it "returns the average rating for the selected video" do
      review_1 = Fabricate(:review, user: user, video: video)
      review_2 = Fabricate(:review, user: user, video: video)
      average = Review.where(video: video).average(:rating).to_s
      expect(VideoDecorator.new(video).avg_rating).to eq("#{ average }/5.0")
    end
  end
end
