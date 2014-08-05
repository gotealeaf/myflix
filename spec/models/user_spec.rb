require "spec_helper"
require "pry"

describe User do
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:followings) }
  it { should have_many(:followed_users) }
  it { should have_many(:inverse_followings) }
  it { should have_many(:followers) }
  it { should have_many(:invites) }
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of (:email) }



  describe "in_video_queue?(video)" do
    let(:jim) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "returns true if video is in user queue" do  
      queue_item = Fabricate(:queue_item, user: jim, video: video)
      expect(jim.video_in_queue?(video)).to be_true
    end
    
    it "returns false if video is not in user queue" do
      expect(jim.video_in_queue?(video)).to be_false
    end
  end

  describe "can_follow?(another_user)" do
    let(:jim) { Fabricate(:user) }
    let(:jose) { Fabricate(:user) }
    let(:nigel) { Fabricate(:user) }
    let(:following) { Fabricate(:following, user_id: jim.id, followed_user_id: jose.id) }
    before { jim.followings = [following] }

    it "returns true if current user does not already follow selected user and selected user is not the current user" do
      expect(jim.can_follow?(nigel)).to be_true
    end

    it "returns false if current user already follows selected user" do
      expect(jim.can_follow?(jose)).to be_false
    end

    it "returns false if current user is selected user" do
      expect(jim.can_follow?(jim)).to be_false
    end
  end

  it_behaves_like "generate_token" do
    let(:instance) { Fabricate(:user) }
  end

  describe "follow_and_be_followed_by(other_user)" do
    let(:jim) { Fabricate(:user) }
    let(:mary) { Fabricate(:user) }
    before { jim.follow_and_be_followed_by(mary) }

    it "makes the user follow another user" do
      expect(jim.followers).to eq([mary])
    end

    it "makes the other user follow the user" do
      expect(mary.followers).to eq([jim])
    end

    it "does not follow itself" do
      expect(jim.followers).to_not eq([jim])
    end
  end
end





