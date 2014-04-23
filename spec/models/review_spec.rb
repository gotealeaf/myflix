require 'spec_helper'

describe Review do
  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:video) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      review = Fabricate(:review)
      expect(review.video_title).to eq review.video.title
    end
  end
end