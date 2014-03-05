require 'spec_helper'
require 'pry'
require 'shoulda-matchers'


describe QueueItem do

  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

  describe 'self.get_queue_items_for_video_and_user' do
    it 'returns queue_items for that user and video' do
      adam = Fabricate(:user)
      video = Fabricate(:video)
      video1 = Fabricate(:video)
      queue_item_1 = Fabricate(:queue_item, user: adam, video: video)
      queue_item_2 = Fabricate(:queue_item, user: adam, video: video1)
      expect(QueueItem.get_queue_items_for_video_and_user(video.id, adam.id)).to eq([queue_item_1])
    end
  end

end
