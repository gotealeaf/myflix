require 'spec_helper'

describe UserRelationship do
  it { should belong_to(:followee).class_name(:User).with_foreign_key(:user_id) }
  it { should belong_to(:follower).class_name(:User) }

  it "validates the uniqueness of the relationshop" do
    relationship = Fabricate(:user_relationship)
    expect(relationship).to validate_uniqueness_of(:followee).scoped_to(:follower_id)
  end
end