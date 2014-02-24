require 'spec_helper'
require 'pry'
require 'shoulda-matchers'


describe QueueItem do

  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

end
