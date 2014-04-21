require 'spec_helper'

describe Relationship do
  it { should belong_to(:leader).class_name('User') }
  it { should belong_to(:follower).class_name('User') }
  it { should validate_uniqueness_of(:leader_id).scoped_to(:follower_id).with_message("You are already following that person.") }

  it "allows a user to follow a leader" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    alice.follow!(bob)
    expect(alice.leaders.first).to be_instance_of(User)
    expect(alice.following_relationships.count).to eq(1)
  end

  it "allows a user to have many leaders" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    charles = Fabricate(:user)
    diane = Fabricate(:user)
    emmy = Fabricate(:user)
    alice.follow!(bob)
    alice.follow!(charles)
    alice.follow!(diane)
    alice.follow!(emmy)
    expect(alice.leaders.count).to eq(4)
    expect(alice.following_relationships.count).to eq(4)
  end

  it "allows a user to have a follower" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    bob.follow!(alice)
    expect(alice.followers.first).to be_instance_of(User)
    expect(alice.leading_relationships.count).to eq(1)
  end

  it "allows a user to have many followers" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    charles = Fabricate(:user)
    diane = Fabricate(:user)
    emmy = Fabricate(:user)
    bob.follow!(alice)
    charles.follow!(alice)
    diane.follow!(alice)
    emmy.follow!(alice)
    expect(alice.followers.count).to eq(4)
    expect(alice.leading_relationships.count).to eq(4)
  end

  it "does not allow a user to follow themselves" do
    alice = Fabricate(:user)
    relationship = Relationship.create(leader_id: 1, follower_id: 1)
    expect(alice.followers.count).to eq(0)
    expect(alice.leaders.count).to eq(0)
    expect(relationship.errors.full_messages).to include("You cannot follow yourself.")
  end
end