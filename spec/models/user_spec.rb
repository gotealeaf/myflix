require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items).order("ranking") }
  it { should have_many(:videos) }
  it { should have_many(:leader_relationships).order("created_at DESC") }
  it { should have_many(:leaders) }
  it { should have_many(:follower_relationships).order("created_at DESC") }
  it { should have_many(:followers) }

  it_behaves_like "tokenable", :user

  describe "#following?" do
    it "returns true if following" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower_id: bob.id, leader_id: alice.id)
      expect(bob.following?(alice)).to eq(true)

    end
    it "returns false if not following" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      expect(bob.following?(alice)).to eq(false)
    end

    it "does not allow a user to follow himself" do
      alice = Fabricate(:user)
      expect(alice.allow_to_follow?(alice)).to eq(false)
    end
  end
end