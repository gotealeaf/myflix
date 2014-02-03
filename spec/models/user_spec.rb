require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :full_name }
  it { should have_secure_password }
  it { should validate_presence_of :password }
  it { should have_many :reviews }
  it { should have_many :queue_items }

  let(:user) { Fabricate(:user) }
  it 'retrieves reviews in reverse cronological order' do
    review1 = Fabricate(:review, creator: user, created_at: 1.day.ago)
    review2 = Fabricate(:review, creator: user)
    expect(user.reviews).to eq([review2, review1])
  end

  it 'retrieves queued_items in ascending order sorted by position' do
    queue_item1 = Fabricate(:queue_item, user: user, position: 2)
    queue_item2 = Fabricate(:queue_item, user: user, position: 1)
    expect(user.queue_items).to eq([queue_item2, queue_item1])
  end

  describe '#has_queued_video?' do
    it 'returns true if video exists in users queue' do
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user, video: video, position: 2)
      expect(user.has_queued_video?(video)).to eq(true)
    end

    it 'returns false if video does not exist in users queue' do
      video = Fabricate(:video)
      expect(user.has_queued_video?(video)).to eq(false)
    end
  end

  describe '#normalize_queue_positions' do
    it 'takes out gaps in position numbering' do
      queue_item1 = Fabricate(:queue_item, user: user, position: 1)
      queue_item2 = Fabricate(:queue_item, user: user, position: 4)
      user.normalize_queue_positions
      expect(queue_item1.reload.position).to eq(1)
      expect(queue_item2.reload.position).to eq(2)
    end

    it 'breaks position ties, newest queued item wins' do
      queue_item1 = Fabricate(:queue_item, user: user, position: 1, created_at: 1.day.ago)
      queue_item2 = Fabricate(:queue_item, user: user, position: 1)
      user.normalize_queue_positions
      expect(queue_item1.reload.position).to eq(2)
      expect(queue_item2.reload.position).to eq(1)
    end
  end
end
