require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "#recent_videos" do
    it "returns no videos" do
      biographies = Category.create(name: "Biographies")
      expect(biographies.recent_videos.count).to eq(0)
    end
    it "finds less than six videos" do
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies)
      expect(biographies.recent_videos.count).to eq(3)
    end
    it "finds more than six videos but returns only six videos" do
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies)
      video4 = Video.create(title: "Fourth Video", description: "great video", category: biographies)
      video5 = Video.create(title: "Fifth Video", description: "great video", category: biographies)
      video6 = Video.create(title: "Sixth Video", description: "great video", category: biographies)
      video7 = Video.create(title: "Seventh Video", description: "great video", category: biographies)
      expect(biographies.recent_videos.count).to eq(6)
    end
    it "finds six videos in reverse chronological order, sorted by created_at" do
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies, created_at: 1.day.ago)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies, created_at: 2.days.ago)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies, created_at: 3.days.ago)
      video4 = Video.create(title: "Fourth Video", description: "great video", category: biographies, created_at: 4.days.ago)
      video5 = Video.create(title: "Fifth Video", description: "great video", category: biographies, created_at: 7.days.ago)
      video6 = Video.create(title: "Sixth Video", description: "great video", category: biographies, created_at: 5.days.ago)
      video7 = Video.create(title: "Seventh Video", description: "great video", category: biographies, created_at: 6.days.ago)
      expect(biographies.recent_videos).to eq([video1, video2, video3, video4, video6, video7])
    end
  end
end