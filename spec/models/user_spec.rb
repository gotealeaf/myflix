require 'spec_helper'

describe User do
  it { should validate_presence_of(:email)}
  it { should validate_uniqueness_of(:email)}
  it { should validate_presence_of(:full_name)}
  it { should validate_presence_of(:password)}
  it { should ensure_length_of(:password)}
  it { should validate_presence_of(:password_confirmation)}
  it { should ensure_length_of(:password_confirmation)}
  it { should have_secure_password }
  it { should have_many(:queue_items).order("ranking") }

  describe "#queued?(video)" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "returns true when user queued the video" do
      Fabricate(:queue_item, creator: user, video: video)
      user.queued?(video).should be true
    end
    it "returns false when user has not queued the video" do
      user.queued?(video).should be false
    end
  end
end
