require 'spec_helper'

describe Relationship do
  it { should belong_to(:user) }
  it { should belong_to(:follower).class_name('User') }
  it do 
    should validate_uniqueness_of(:user_id).scoped_to(:follower_id).
      with_message("has already been followed by you.") 
  end

  it "allows a user to have a follower" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    Fabricate(:relationship, user_id: 1, follower_id: 2)
    expect(alice.followers.first).to be_instance_of(User)
  end

  it "allows a user to have many followers" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    charles = Fabricate(:user)
    diane = Fabricate(:user)
    emmy = Fabricate(:user)
    Fabricate(:relationship, user_id: 1, follower_id: 2)
    Fabricate(:relationship, user_id: 1, follower_id: 3)
    Fabricate(:relationship, user_id: 1, follower_id: 4)
    Fabricate(:relationship, user_id: 1, follower_id: 5)
    expect(alice.followers.count).to eq(4)
    expect(alice.followers.first).to be_instance_of(User)
  end

  it "allows a user to follow a leader" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    Fabricate(:relationship, user_id: 2, follower_id: 1)
    expect(alice.leaders.first).to be_instance_of(User)
  end

  it "allows a user to have many leaders" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    charles = Fabricate(:user)
    diane = Fabricate(:user)
    emmy = Fabricate(:user)
    Fabricate(:relationship, user_id: 2, follower_id: 1)
    Fabricate(:relationship, user_id: 3, follower_id: 1)
    Fabricate(:relationship, user_id: 4, follower_id: 1)
    Fabricate(:relationship, user_id: 5, follower_id: 1)
    expect(alice.leaders.count).to eq(4)
    expect(alice.leaders.first).to be_instance_of(User)
  end

  it "does not allow a user to follow themselves" do
    alice = Fabricate(:user)
    relationship = Relationship.create(user_id: 1, follower_id: 1)
    expect(alice.followers.count).to eq(0)
    expect(relationship.errors.full_messages).to include("You cannot follow yourself.")
  end
end