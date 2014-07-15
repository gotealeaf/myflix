require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:email)}
  it {should have_many(:queue_items).order("position")}
  it {should have_many(:reviews)}

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      lalaine =  Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: lalaine, video: video)
      lalaine.queued_video?(video).should be_true
    end
    it "returns false when the user hasn't queued the video" do
      lalaine =  Fabricate(:user)
      video = Fabricate(:video)
      lalaine.queued_video?(video).should be_false
    end
  end
end