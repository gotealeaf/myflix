require 'spec_helper'

describe Review do
  it { should belong_to(:creator) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:creator) }

  describe '::find_rating_by_creator_and_video' do
    it 'returns review matching given video, left by current user' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, creator: user, video: video)

      expect(Review.find_rating_by_creator_and_video(user, video)).to eq(review.rating)
    end
  end
end
