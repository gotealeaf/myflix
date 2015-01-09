require 'rails_helper'

describe MyQueue do
  it { should have_many(:videos).through(:my_queue_videos) }
  it { should have_many(:my_queue_videos)}
  it { should belong_to(:user) }
end
