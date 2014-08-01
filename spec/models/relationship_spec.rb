require 'spec_helper'

describe Relationship do
  it { should validate_presence_of(:follower) }
  it { should validate_presence_of(:followed) }
  it { should belong_to(:follower) }
  it { should belong_to(:followed) }

  let(:current_user) { Fabricate(:user) }
  describe "#cant_follow_youself" do
    it "user cannot follow itslef" do
      current_user.relationships.create(followed: current_user)
      expect(current_user.relationships.count).to eq(0)
    end

    it "user can follow others" do
      another_user = Fabricate(:user)
      current_user.relationships.create(followed: another_user)
      expect(current_user.relationships.count).to eq(1)
    end
  end
end
