require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presense_of(:user) }
  it { should validate_presense_of(:video) }
end