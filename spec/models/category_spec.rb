require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns the videos in reverse chronological order by created_at" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "funny video", category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end
    it "returns all the videos if there are fewer than six videos" do
    comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "funny video", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end
    it "returns six videos if there are more than six videos" do
      comedies = Category.create(name: "comedies")
      7.times { Video.create(title: "Hey!", description: "A video", category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end
    it "returns the most recent six videos" do
      comedies = Category.create(name: "comedies")
      6.times { Video.create(title: "Hey!", description: "A video", category: comedies)}
      tonights_show = Video.create(title: "Tonight's show", description: "Talk show", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonights_show)
    end
    it "returns an empty array if the category does not have any videos" do
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end
  end  
end