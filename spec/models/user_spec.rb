require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password).on(:create) }
  it { should validate_presence_of(:password_confirmation).on(:create) }
  it { should have_secure_password }
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should have_many(:queue_items).order(position: :asc) }
  it { should have_many(:videos).through(:queue_items) }
  it { should have_many(:user_relationships) }
  it { should have_many(:following_relationships).class_name(:UserRelationship).with_foreign_key(:follower_id) }

  it "validates uniqueness of email" do
    user = User.create(email: "smaug@lonelymountain.com", full_name: "Smaug the Magnificent", password: "gold", password_confirmation: "gold")
    expect(user).to validate_uniqueness_of :email
  end

  describe "#queued_video?" do
    it "returns true if the video is in the user's queue" do
      odin = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: odin, video: video)
      expect(odin.queued_video?(video)).to be_true
    end

    it "returns false if the video is not in the user's queue" do
      odin = Fabricate(:user)
      video = Fabricate(:video)
      expect(odin.queued_video?(video)).to be_false
    end
  end
end