require 'spec_helper'

describe Category do 
  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}

  describe "#recent_videos" do
    it "returns videos in reverse chronical order by created_at" do
      thriller = Category.create(name:"thriller")
      found = Video.create(title:'Found Highway', description: 'masterpiece!', category: thriller, created_at: 1.day.ago)
      lost = Video.create(title: 'Lost Highway', description:'nightmare!', category: thriller)
      expect(thriller.recent_videos).to eq([lost, found])
    end

    it "returns all videos if there are less than 6" do
      thriller = Category.create(name:"thriller")
      found = Video.create(title:'Found Highway', description: 'masterpiece!', category: thriller, created_at: 1.day.ago)
      lost = Video.create(title: 'Lost Highway', description:'nightmare!', category: thriller)
      expect(thriller.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6" do
      thriller = Category.create(name:"thriller")
      7.times {Video.create(title: "Lala",description: "Lili", category: thriller)}
      expect(thriller.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      thriller = Category.create(name:"thriller")
      6.times {Video.create(title: "Lala",description: "Lili", category: thriller)}
      another_video = Video.create(title:"Another", description:"Interesting", category: thriller, created_at: 1.day.ago)
      expect(thriller.recent_videos).not_to include(another_video)
    end

    it "returns an empty array if there are no videos in the category" do
      scifi = Category.create(name:"scifi")
      expect(scifi.recent_videos).to eq([])
    end
  end

end