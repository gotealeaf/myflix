require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }
  describe "queued_video?" do
    it "returns true if video is in queue of current_user" do
      alice = Fabricate(:user)
      
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user_id: alice.id, video: video)
      
      expect(alice.queued_video?(video)).to be true
    end
    it "returns false when user doesn't have the queued video" do
      alice = Fabricate(:user)
      
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user_id: alice.id)
      
      expect(alice.queued_video?(video)).to be false
    end
  end
end
