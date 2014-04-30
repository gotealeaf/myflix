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
  it { should have_many(:followers).through(:user_relationships) }
  it { should have_many(:following_relationships).class_name(:UserRelationship).with_foreign_key(:follower_id) }
  it { should have_many(:followees).through(:following_relationships) }

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

  describe "#follows?" do
    it "returns true if the user already follows the passed user" do
      john = Fabricate(:user)
      marcy = Fabricate(:user)
      Fabricate(:user_relationship, followee: john, follower: marcy)
      expect(marcy.follows?(john)).to be_true
    end
    
    it "returns false if the user does not follow the passed user" do
      john = Fabricate(:user)
      marcy = Fabricate(:user)
      expect(marcy.follows?(john)).to be_false
    end
  end

  describe "#can_follow?(user)" do
    it "returns false if the user already follows the passed user" do
      john = Fabricate(:user)
      marcy = Fabricate(:user)
      Fabricate(:user_relationship, followee: john, follower: marcy)
      expect(marcy.can_follow?(john)).to be_false
    end

    it "returns true if the user does not follow the passed user" do
      john = Fabricate(:user)
      marcy = Fabricate(:user)
      expect(marcy.can_follow?(john)).to be_true
    end

    it "returns false if the followee is the user" do
      john = Fabricate(:user)
      expect(john.can_follow?(john)).to be_false
    end
  end

  describe "#generate_password_token" do
    it "sets the password_token attribute for the user" do
      billy = Fabricate(:user)
      billy.generate_password_token
      expect(billy.reload.password_token).to_not be_blank
    end
  end
end