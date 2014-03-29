require 'spec_helper'

describe Relationship do
  it { should belong_to(:follower) }
  it { should belong_to(:leader) }
end
