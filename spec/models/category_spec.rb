require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "#recent_videos" do 
    it "returns an empty array if there are no videos" do 
      cat = Category.create(name: "Test")
      expect(cat.recent_videos).to eq([])
    end

    it "returns all videos if there are less than 6 in the category" do
      cat = Category.create(name: "Test")
      video1 = Video.create(title: "Video 1", description: "Description 1", categories: [cat])
      video2 = Video.create(title: "Video 2", description: "Description 2", categories: [cat])
      video3 = Video.create(title: "Video 3", description: "Description 3", categories: [cat])
      expect(cat.recent_videos).to include(video1, video2, video3)
    end

    it "returns only 6 videos if there are more than 6 in the category" do 
      cat = Category.create(name: "Test")
      video1 = Video.create(title: "Video 1", description: "Description 1", categories: [cat])
      video2 = Video.create(title: "Video 2", description: "Description 2", categories: [cat])
      video3 = Video.create(title: "Video 3", description: "Description 3", categories: [cat])
      video4 = Video.create(title: "Video 4", description: "Description 4", categories: [cat])
      video5 = Video.create(title: "Video 5", description: "Description 5", categories: [cat])
      video6 = Video.create(title: "Video 6", description: "Description 6", categories: [cat])
      video7 = Video.create(title: "Video 7", description: "Description 7", categories: [cat], created_at: 1.day.ago)
      video8 = Video.create(title: "Video 8", description: "Description 8", categories: [cat], created_at: 1.day.ago)

      # Figure out how to do include only.
      expect(cat.recent_videos).to include(video1, video2, video3, video4, video5, video6)
      expect(cat.recent_videos).to_not include(video7, video8) 
    end
  
    it "returns the videos in reverse chronological order (newest first)" do
      cat = Category.create(name: "Test")
      video1 = Video.create(title: "Video 1", description: "Description 1", categories: [cat], created_at: 1.day.ago)
      video2 = Video.create(title: "Video 2", description: "Description 2", categories: [cat], created_at: 2.days.ago)
      video3 = Video.create(title: "Video 3", description: "Description 3", categories: [cat], created_at: 30.seconds.ago)
      expect(cat.recent_videos).to eq([video3, video1, video2])
    end
  end
end