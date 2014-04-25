require 'spec_helper'

describe UserRelationship do
  it { should belong_to(:user) }
  it { should belong_to(:follower).class_name('User') }
end