require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items).order(:position) }

  it { should have_many(:following_relationships) }
  it { should have_many(:followers) }
  it { should have_many(:leading_relationships) }
  it { should have_many(:leaders) }

  describe "follows?" do

    it "identifies follower" do
      joe = Fabricate(:user)
      hank = Fabricate(:user)
      following = Fabricate(:relationship , leader:joe, follower: hank)
      expect(hank.follows?(joe)).to be(true)
    end

    it "returns false for non-follower" do
      joe = Fabricate(:user)
      hank = Fabricate(:user)
      expect(hank.follows?(joe)).to be(false)
    end

  end

end
