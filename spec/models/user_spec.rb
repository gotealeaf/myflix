require "spec_helper"

describe User do
  it { should validate_presence_of :fullname }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:following_relationships) }
  it { should have_many(:leading_relationships) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end

  describe "#queue_video?" do
    it "should return true when the user queued the video" do
      video = Fabricate(:video)
      desmond = Fabricate(:user)
      Fabricate(:queue_item, user: desmond, video: video)
      expect(desmond.queued_video?(video)).to be_true
    end
    it "should return false when the user did not queue the video" do
      video = Fabricate(:video)
      desmond = Fabricate(:user)
      expect(desmond.queued_video?(video)).to be_false
    end
  end

  describe "#follows?" do
    it "should return true if the user has a following relationship with another user" do
      desmond = Fabricate(:user)
      linda = Fabricate(:user)
      Relationship.create(follower: desmond, leader: linda)
      expect(desmond.follows?(linda)).to be_true
    end
    it "should retuen false if the user has not a following relationship with another user" do
      desmond = Fabricate(:user)
      linda = Fabricate(:user)
      expect(desmond.follows?(linda)).to be_false
    end
  end

  describe "#follow" do
    it "should follow another user" do
      desmond = Fabricate(:user)
      linda = Fabricate(:user)
      desmond.follow(linda)
      expect(desmond.follows?(linda)).to be_true
    end
    it "should not follow self" do
      desmond = Fabricate(:user)
      desmond.follow(desmond)
      expect(desmond.follows?(desmond)).to be_false
    end
  end

  describe "#deactivate!" do
    it "should deactivate a active user" do
      desmond = Fabricate(:user, active: true)
      desmond.deactivate!
      expect(desmond).not_to be_active
    end
  end
end
