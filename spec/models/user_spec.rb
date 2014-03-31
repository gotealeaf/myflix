require 'spec_helper'

describe User do 
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) } 

  describe "#queued_item?" do
    it "should return false if user has not added video to queue" do
      alice = Fabricate(:user)
      video = Fabricate(:video)

      alice.queued_item?(video)
      expect(alice.queued_item?(video)).to be_false
    end

    it "should return true if user has added video to queue" do
      alice = Fabricate(:user)
      comedies = Fabricate(:category, name: "Comedies")
      south_park = Fabricate(:video, category: comedies)
      queue_item = Fabricate(:queue_item, user: alice, video: south_park)

      alice.queued_item?(south_park)
      expect(alice.queued_item?(south_park)).to be_true
    end
  end

end