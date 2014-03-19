require 'spec_helper'

describe Review do
  it { should belong_to(:video) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:review_text) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

  it "prevents a user from reviewing the same video twice" do
    Fabricate(:review, user_id: 1, video_id: 1)
    second_review = Fabricate.build(:review, user_id: 1, video_id: 1)
    expect(second_review).not_to be_valid  
  end

  it "allows a user to review multiple videos" do
    Fabricate(:review, user_id: 1, video_id: 1)
    second_review = Fabricate.build(:review, user_id: 1, video_id: 2)
    expect(second_review).to be_valid  
  end

  it "allows a video to have multiple reviews from different users" do
    Fabricate(:review, user_id: 1, video_id: 1)
    second_review = Fabricate.build(:review, user_id: 2, video_id: 1)
    expect(second_review).to be_valid
  end
end