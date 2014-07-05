require 'rails_helper.rb'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }

  it "generates a random token when user is created" do
    joe = Fabricate(:user)
    expect(joe.token).to be_present
  end

  it "password must be greater than five characters" do
    u = User.create(email: "joshleeman@gmail.com", password: "abc", full_name: "Josh Leeman")
    expect(User.count).to eq(0)
  end

  it "email must be unique" do
    u = User.create(email: "joshleeman@gmail.com", password: "abcdef", full_name: "Josh Leeman")
    u2 = User.create(email: "joshleeman@gmail.com", password: "abcdef", full_name: "Josh Leeman")
    expect(User.count).to eq(1)
  end

  describe "#queued_video?" do
    it "returns true when the user has queued the video" do
      john = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video_id: video.id, user_id: john.id)
      expect(john.queued_video?(video)).to eq(true)
    end

    it "returns false when the user has not queued the video" do
      john = Fabricate(:user)
      video = Fabricate(:video)
      expect(john.queued_video?(video)).to eq(false)
    end
  end

  describe "#follows?" do
    it "returns true if the current user has following relationship with another user" do
      joe = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: joe)
      expect(joe.follows?(bob)).to eq(true)
    end

    it "returns false if the current user does not have following relationship with another user" do
      joe = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: joe, follower: bob)
      expect(joe.follows?(bob)).to eq(false)
    end
  end
end
