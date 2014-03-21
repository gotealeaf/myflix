require 'spec_helper'

describe ApplicationHelper do
  describe "#already_queue_item_for_video_and_user?" do
    it 'returns true if there is an item already in the queue' do
      user = Fabricate(:user)
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user, video: video1)
      queue_item1 = Fabricate(:queue_item, user: user, video: video2)
      expect(helper.already_queue_item_for_video_and_user?(video1, user)).to be true
    end
  end
end
