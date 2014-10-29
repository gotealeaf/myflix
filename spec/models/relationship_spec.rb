require 'spec_helper'

describe Relationship do
  
  it { should belong_to(:follower).class_name('User').with_foreign_key('follower_id') }
  it { should belong_to(:following).class_name('User').with_foreign_key('following_id') }
  it { should validate_uniqueness_of(:following_id).scoped_to(:follower_id) }
  
  it "raises a validation error if user tries to follow themself" do
    darren = Fabricate(:user)
    relationship = Relationship.new(follower: darren, following: darren)
    relationship.valid?
    expect(relationship.errors.full_messages).to include ('Follower cannot be the same person as the one being followed')
  end
  
end