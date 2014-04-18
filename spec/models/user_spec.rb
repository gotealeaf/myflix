require 'spec_helper'

describe User do
  it { should have_many(:reviews) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }
  it { should have_many(:queue_items).order(:position) }

  describe "#queued_video?" do
    before do
      user = Fabricate(:user)
      video = Fabricate(:video)
    end

    it "returns true if video is in user has queued the video" do
      Fabricate(:queue_item, video_id: Video.first.id, user_id: User.first.id)
      expect(User.first.queued_video?(Video.first)).to be_true
    end

    it "returns false if video has not queued the video" do
      expect(User.first.queued_video?(Video.first)).to be_false
    end
  end
end