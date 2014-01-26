require 'spec_helper'

describe User do
   it {should have_many(:queue_items).order(:position)}


describe '#is_already_queued?' do
  set_user_and_session
  set_video(1)
  set_queue_item1
  
  it "should return true if the video is in the queue" do
  # expect(current_user.queue_items.map(&:video).include?(video1)).to eq(true)
  expect(is_already_queued?(video1)).to be_true
  end
end #method

  



end
