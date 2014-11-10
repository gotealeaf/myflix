require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:follower_relationships).class_name('Relationship').with_foreign_key('following_id') }
  it { should have_many(:following_relationships).class_name('Relationship').with_foreign_key('follower_id') }
  it { should have_many(:follower_users).through(:follower_relationships).source(:follower) }
  it { should have_many(:following_users).through(:following_relationships).source(:following) }
  it { should have_many(:invitations) }
  
  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end
  
  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be_truthy
    end
    it "returns false when the user has not queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to be_falsey
    end
  end
end