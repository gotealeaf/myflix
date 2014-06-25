require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }

  it 'creates a random token when a user is created' do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

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

  describe "#follows?" do
    
    it "returns true of the current user is following another user" do
     alice = Fabricate(:user)

      bob = Fabricate(:user)

     Fabricate(:relationship, follower: alice, leader: bob)

      expect(alice.follows?(bob)).to be true

    end

    it "returns false if the current user is not following another user" do
      alice = Fabricate(:user)

      bob = Fabricate(:user)
      expect(alice.follows?(bob)).to be false
    end
  end
end
