require 'spec_helper'

describe Relationship do
  
  it { should belong_to(:follower).class_name('User').with_foreign_key('follower_id') }
  it { should belong_to(:following).class_name('User').with_foreign_key('following_id') }
  it { should validate_uniqueness_of(:following_id).scoped_to(:follower_id) }
  
end