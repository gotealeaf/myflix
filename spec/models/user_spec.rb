require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:list_order) }
  it { should have_many(:reviews).order("created_at DESC")}
  
  describe "#queued_video?" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    it 'should return true if user queued this video' do
      queue_item1 = Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_true
    end
    
    it 'should return false if user did not queue this video' do
      user.queued_video?(video).should be_false
    end
  end
end