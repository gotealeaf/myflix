require 'spec_helper'

describe UserRelationship do
  it { should belong_to(:followee).class_name(:User).with_foreign_key(:user_id) }
  it { should belong_to(:follower).class_name(:User) }
end