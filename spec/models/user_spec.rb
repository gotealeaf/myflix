require 'spec_helper'

describe User do 
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  #it { should have_many(:queue_items).order(:position) } 

  describe "#follow!(other_user)" do
    it "should add the other_user to the user's array of followed users" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)

      alice.follow!(bob)
      expect(alice.followed_users.first).to eq(bob)
    end
  end

  describe "#following?(other_user)" do
    it "should return true if the user is following the other user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)

      alice.follow!(bob)
      expect(alice.following?(bob)).to be_true
    end
    it "should return false if the user is not following the other user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      cat = Fabricate(:user)

      alice.follow!(bob)
      expect(alice.following?(cat)).to be_false
    end
  end

  describe "#unfollow!(other_user)" do
    it "should destroy the user's followed relationship with the other_user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)

      alice.follow!(bob)
      alice.unfollow!(bob)
      expect(alice.following?(bob)).to be_false
    end
  end

  describe "#queued_item?" do
    it "should return false if user has not added video to queue" do
      alice = Fabricate(:user)
      video = Fabricate(:video)

      alice.queued_item?(video)
      expect(alice.queued_item?(video)).to be_false
    end

    it "should return true if user has added video to queue" do
      alice = Fabricate(:user)
      comedies = Fabricate(:category, name: "Comedies")
      south_park = Fabricate(:video, category: comedies)
      queue_item = Fabricate(:queue_item, user: alice, video: south_park)

      alice.queued_item?(south_park)
      expect(alice.queued_item?(south_park)).to be_true
    end
  end
end