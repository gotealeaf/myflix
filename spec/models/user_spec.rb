require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }

  it { should have_many(:queue_items).order(:order) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many :followers }
  it { should have_many :followed_people }
  
  it_behaves_like "require_token" do
    let(:object) { Fabricate :user }
  end

  it "should be validate uniq of email " do
    user = Fabricate :user
    user.save
    expect(user).to validate_uniqueness_of :email
  end
  
  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate :user
      video = Fabricate :video
      Fabricate :queue_item, user: user, video: video

      user.queued_video?(video).should be_true
    end

    it "returns false when the user hasn't queued the video" do
      user = Fabricate :user
      video = Fabricate :video
      
      user.queued_video?(video).should be_false
    end
  end

  describe "#count_queued_videos" do
    it "returns the number of wueued videos by the user" do
      ana = Fabricate :user
      the_wire = Fabricate :video
      the_sopranos = Fabricate :video
      queue_item1 = Fabricate :queue_item, user: ana, video: the_wire
      queue_item2 = Fabricate :queue_item, user: ana, video: the_sopranos

      ana.count_queued_videos.should eq(2)
    end
  end

  describe "#follows?" do
    it "returns true when a the user already follows another user" do
      ana = Fabricate :user
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana   

      ana.follows?(tom).should be_true
    end

    it "returns false when a the user do not follow another user" do
      ana = Fabricate :user
      tom = Fabricate :user     

      ana.follows?(tom).should be_false
    end
  end

  describe "#can_follow?" do
    it "returns false when a the user already follows another user" do
      ana = Fabricate :user
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana   

      ana.can_follow?(tom).should be_false
    end

    it "returns true when a the user do not follow another user" do
      ana = Fabricate :user
      tom = Fabricate :user     

      ana.can_follow?(tom).should be_true
    end  

    it "returns false when the user is the current user" do
      ana = Fabricate :user
      ana.can_follow?(ana).should be_false
    end  
  end

  describe "follow" do
    it "follows another user" do
      ana = Fabricate :user
      roberto = Fabricate :user
      ana.follow roberto

      expect(ana.follows? roberto).to be_true
    end

    it "does not follow one self" do
      ana = Fabricate :user
      ana.follow ana

      expect(ana.follows? ana).to be_false
    end
  end

  describe "admin?" do
    it "returns true if the user is an admin" do
      ana = Fabricate :user, admin: true
      expect(ana.admin?).to be_true
    end

    it "returns false if the user is not an admin" do
      ana = Fabricate :user, admin: false
      expect(ana.admin?).to be_false
    end
  end
end