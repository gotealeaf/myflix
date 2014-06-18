require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should ensure_length_of(:full_name).is_at_least(3).is_at_most(25) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:list_order) }
  it { should have_many(:reviews).order("created_at DESC")}
  
  it_behaves_like 'generate token' do
    let(:object) { Fabricate(:user) }
  end
  
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
  end #ends #queued_video?
  
  describe "#follows?" do
    it 'should return true if the user has a following relationship with another user' do
      jane = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: jane)
      expect(jane.follows?(bob)).to be_true
    end
    it 'should return false if the user does not have a following relationship with another user' do
      jane = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: jane, follower: bob)
      expect(jane.follows?(bob)).to be_false
    end
  end # ends follows
  
  describe "#follow" do
    
    it 'follows another user' do
      jane = Fabricate(:user)
      bob = Fabricate(:user)
      bob.follow(jane)
      expect(bob.follows?(jane)).to be_true
    end
    
    it 'does not follow one self' do
      jane = Fabricate(:user)
      jane.follow(jane)
      expect(jane.follows?(jane)).to be_false
    end
  end #ends follow
  
  describe "#deactivate!" do
    it "deactivates an active user" do
      jane = Fabricate(:user, active: true)
      jane.deactivate!
      expect(jane).not_to be_active
    end
  end
  
  describe "#next_billing_date" do
    it "shows the user's next billing date" do
      jane = Fabricate(:user)
      payment = Fabricate(:payment, user: jane, created_at: Time.now)
      expect(jane.next_billing_date).to eq(payment.created_at + 1.month)
      
    end
  end
  
  describe "previous_billing_date" do
    it "shows the user's previous billing date" do
      jane = Fabricate(:user)
      payment = Fabricate(:payment, user: jane, created_at: 1.month.ago)
      expect(jane.previous_billing_date).to eq(payment.created_at)
    end
  end
end