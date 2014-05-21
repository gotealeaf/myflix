require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns the videos in the reverse chronical order by created at" do
      comedy = Category.create(name: "Comedy")
      futurama = Video.create(title: "Futurama", description: "Space Travel!", category: comedy, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "Funny video!", category: comedy)
      expect(comedy.recent_videos).to eq([south_park, futurama])
    end
    it "returns all the videos if there are less then 6 videos" do
      comedy = Category.create(name: "Comedy")
      futurama = Video.create(title: "Futurama", description: "Space Travel!", category: comedy, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "Funny video!", category: comedy)
      expect(comedy.recent_videos.count).to eq(2)
    end
    it "returns 6 videos if there are more then 6 videos" do
      comedy = Category.create(name: "Comedy")
      7.times {Video.create(title: "Foo", description: "Bar", category: comedy)}
      expect(comedy.recent_videos.count).to eq(6)
    end	
    it "returns the most recent 6 videos" do
      comedy = Category.create(name: "Comedy")
      6.times {Video.create(title: "Foo", description: "Bar", category: comedy)}
      tonights_show = Video.create(title: "Tonight Show", description: "Talk Show", category: comedy, created_at: 1.day.ago)
      expect(comedy.recent_videos).not_to include([tonights_show])
    end
    it "returns an empty array if the category does not have any videos" do
      comedy = Category.create(name: "Comedy")
      expect(comedy.recent_videos).to eq([])
    end
  end
end