require 'spec_helper'

describe Relationship do
  it { should validate_uniqueness_of(:leader_id).scoped_to(:follower_id) }

  context "for a user with two followers who also follows two people" do
    let(:joe)  { Fabricate(:user) }
    let(:jen)  { Fabricate(:user) }
    let(:jim)  { Fabricate(:user) }

    it "returns the people(leaders) that a user follows" do
      r1 = Fabricate(:relationship, leader: jim, follower: joe)
      r2 = Fabricate(:relationship, leader: jen, follower: joe)
      expect(joe.leaders).to eq([jim, jen])
    end
    it "returns those who follow(ie: leaders of) a specific user" do
      r1 = Fabricate(:relationship, leader: jen, follower: joe)
      expect(jen.followers).to eq([joe])
    end
    it "does not allows users to follow eachother" do
      r1 = Fabricate(:relationship, leader: jen, follower: joe)
      r2 = Fabricate(:relationship, leader: joe, follower: jen)
      expect(joe.leaders).to eq([jen])
      expect(jen.leaders).to eq([joe])
    end
  end

  describe "user_cannot_follow_self" do
    it "should not allow a user to be both the follower & leader" do
      relationship = Relationship.create(leader_id: 1, follower_id: 1)
      expect(relationship).to_not be_valid
    end
  end
end
