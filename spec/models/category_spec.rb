require 'rails_helper'

describe Category do 
  it { should have_many(:videos) }

  describe '#recent_videos' do 
    it "returns all video in the category if less than 6 videos" do 
      commedy = Category.create(name: "comedy")
      video1 = Video.create(title: "hello", description: "hi", category: commedy)
      video2 = Video.create(title: "hello", description: "hi", category: commedy)
      video3 = Video.create(title: "hello", description: "hi", category: commedy)
      expect(commedy.recent_videos.count).to eq(3)
    end

    it "returns videos in the category ordered by created_at reverse-chronologically" do
      commedy = Category.create(name: "comedy")
      video1 = Video.create(title: "hello", description: "hi", category: commedy)
      video2 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 3.minutes.ago)
      video3 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 2.minutes.ago)
      expect(commedy.recent_videos).to eq([video1, video3, video2])
    end

    it "returns 6 most recent videos if more than 6 videos in category" do 
      commedy = Category.create(name: "comedy")
      video1 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 2.minutes.ago)
      video2 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 5.minutes.ago)
      video3 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 10.minutes.ago)
      video4 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 3.minutes.ago)
      video5 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 6.minutes.ago)
      video6 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 1.minutes.ago)
      video7 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 4.minutes.ago)
      video8 = Video.create(title: "hello", description: "hi", category: commedy, created_at: 8.minutes.ago)
      expect(commedy.recent_videos).to eq([video6, video1, video4, video7, video2, video5])
    end

    it "returns empty array if no videos in the category" do 
      commedy = Category.create(name: "comedy")
      expect(commedy.recent_videos).to eq([])
    end
  end
end