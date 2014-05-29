require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      alice = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: alice, video: video)
      alice.queued_video?(video).should be_true
    end
    it "returns false when the user hasn't queued the video" do
      alice = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: alice)
      alice.queued_video?(video).should be_false
    end
  end
end