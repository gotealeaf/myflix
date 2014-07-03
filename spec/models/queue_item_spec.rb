require 'rails_helper'

describe QueueItem do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:video) }
  it { should validate_presence_of(:user) }
  it { should validate_numericality_of(:position).only_integer }

  describe 'video_title' do
    it 'returns the title of the video' do
      video = Fabricate(:video, title: 'Superman')
      q1 = Fabricate(:queue_item, video: video)
      expect(q1.video_title).to eq(video.title)
    end
  end
  
  describe "queue position handling" do
    it 'should provide the next position number based on number of queue items' do
      video = Fabricate(:video, title: 'Superman')
      second_video = Fabricate(:video, title: 'Batman')
      user = Fabricate(:user)
      first_queue_item = Fabricate(:queue_item, user: user, video: video)
      new_queue_item = QueueItem.create(user:user, video: second_video)
      new_queue_item.reload
      expect(new_queue_item.position).to eq(2)
    end
    it '#assign_positions_for_user should update positions from a position array given a user and array' do
      user = Fabricate(:user)
      first_item = Fabricate(:queue_item, position: 1, user: user)
      second_item = Fabricate(:queue_item, position: 2, user: user)
      new_updates = [{id: first_item.id, position: 2}, {id: second_item.id, position: 1}]
      new_positions = QueueItem.assign_positions_for_user(user,new_updates)
      expect(new_positions[0].position).to eq(2)
      expect(new_positions[1].position).to eq(1)
    end
    it '#assign_positions_for_user should return an array' do
      user = Fabricate(:user)
      first_item = Fabricate(:queue_item, position: 1, user: user)
      second_item = Fabricate(:queue_item, position: 2, user: user)
      new_updates = [{id: first_item.id, position: 2}, {id: second_item.id, position: 1}]
      expect(QueueItem.assign_positions_for_user(user,new_updates).class).to eq(Array)
    end
    it '#save_item_positions should save an array of items with new positions' do
      user = Fabricate(:user)
      first_item = Fabricate(:queue_item, position: 1, user: user)
      second_item = Fabricate(:queue_item, position: 2, user: user)
      new_updates = [{id: first_item.id, position: 2}, {id: second_item.id, position: 1}]
      positioned = QueueItem.assign_positions_for_user(user,new_updates)
      save_result = QueueItem.save_positions_for_user(user,positioned)
      expect(save_result).to eq(true)
    end
  end

  describe "rating" do
    it 'returns the rating of the review when present' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:review, user: user, video: video, rating: 4)
      qi = Fabricate(:queue_item, user: user, video: video)
      expect(qi.rating).to eq(4)
    end
    it 'returns nil for the rating if no review present' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      qi = Fabricate(:queue_item, user: user, video: video)
      expect(qi.rating).to be_nil
    end
  end

  describe 'category_name' do
    it 'returns the name of the category for the video' do
      category = Fabricate(:category, name: 'Sci-Fi')
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      qi = Fabricate(:queue_item, user: user, video: video)
      expect(qi.category_name).to eq('Sci-Fi')
    end
  end

  describe 'category' do
    it 'returns the the category for the video' do
      category = Fabricate(:category, name: 'Sci-Fi')
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      qi = Fabricate(:queue_item, user: user, video: video)
      expect(qi.category).to eq(category)
    end
  end
end
