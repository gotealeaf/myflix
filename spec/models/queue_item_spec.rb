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
  
  describe "rating=" do
    it "changes the rating of an existing review" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 1)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
    end
    it "clears the rating of an existing review" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 1)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end
    it "creates a new review if none exists using provided rating" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
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
