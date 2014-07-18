require "spec_helper"

describe User do
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should have_many(:queue_items).order(:position) }
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
end