require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    it "returns an array of videos in reverse by created_at" do
      category = Category.create(name: 'category1')
      video1 = Video.create(title: 'video1', description: 'video1', category: category)
      video2 = Video.create(title: 'video2', description: 'video2', category: category)
      video3 = Video.create(title: 'video3', description: 'video3', category: category)
      video4 = Video.create(title: 'video4', description: 'video4', category: category)
      expect(category.recent_videos).to eq([video4, video3, video2, video1])
    end
    it "returns all videos if there are less than 6 videos" do
      category = Category.create(name: 'category1')
      video1 = Video.create(title: 'video1', description: 'video1', category: category)
      video2 = Video.create(title: 'video2', description: 'video2', category: category)
      video3 = Video.create(title: 'video3', description: 'video3', category: category)
      video4 = Video.create(title: 'video4', description: 'video4', category: category)
      expect(category.recent_videos.count).to eq(4)
    end
    it "returns 6 videos if there are more than 6 videos" do
      category = Category.create(name: 'category1')
      video1 = Video.create(title: 'video1', description: 'video1', category: category)
      video2 = Video.create(title: 'video2', description: 'video2', category: category)
      video3 = Video.create(title: 'video3', description: 'video3', category: category)
      video4 = Video.create(title: 'video4', description: 'video4', category: category)
      video5 = Video.create(title: 'video5', description: 'video5', category: category)
      video6 = Video.create(title: 'video6', description: 'video6', category: category)
      video7 = Video.create(title: 'video7', description: 'video7', category: category)
      video8 = Video.create(title: 'video8', description: 'video8', category: category)
      expect(category.recent_videos.count).to eq(6)
    end
    it "returns most recent 6 videos" do
      category = Category.create(name: 'category1')
      video1 = Video.create(title: 'video1', description: 'video1', category: category)
      video2 = Video.create(title: 'video2', description: 'video2', category: category)
      video3 = Video.create(title: 'video3', description: 'video3', category: category)
      video4 = Video.create(title: 'video4', description: 'video4', category: category)
      video5 = Video.create(title: 'video5', description: 'video5', category: category)
      video6 = Video.create(title: 'video6', description: 'video6', category: category)
      video7 = Video.create(title: 'video7', description: 'video7', category: category)
      video8 = Video.create(title: 'video8', description: 'video8', category: category)
      expect(category.recent_videos).to eq([video8, video7, video6, video5, video4, video3])
    end
    it "returns empty array if there is no any video" do
      category = Category.create(name: 'category1')
      expect(category.recent_videos).to eq([])
    end
  end
end
