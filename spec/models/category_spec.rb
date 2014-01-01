require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
  	it "returns the videos in reverse chronological order by created at" do
  		comedies = Category.create(name: "Comedies")
    	futurama = Video.create(title: "Futurama", description: "Pizza Space Travel", category: comedies, created_at: 1.day.ago)
      family_guy = Video.create(title: "Family Guy", description: "Peter's escapades", category: comedies)
      expect(comedies.recent_videos).to eq([family_guy, futurama])
  	end
  	it "returns an empty array if there are no videos in the category" do
  		comedies = Category.create(name: comedies)
  		expect(comedies.recent_videos).to eq([])
  	end
    it "returns all videos if there are less than 6" do
    	comedies = Category.create(name: "comedies")
    	futurama = Video.create(title: "Futurama", description: "Pizza Space Travel", category: comedies)
      family_guy = Video.create(title: "Family Guy", description: "Peter's escapades", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end
    it "returns 6 videos if there are more than 6" do 
    	comedies = Category.create(name: "comedies")
     	7.times { Video.create(title: "One of Seven Videos", description: "Very similar to others", category: comedies)}
     	expect(comedies.recent_videos.count).to eq(6)
    end
    it "returns the most recent 6 videos" do
    	comedies = Category.create(name: "comedies")
     	6.times { Video.create(title: "One of Seven Videos", description: "Very similar to others", category: comedies)}
     	tonights_show = Video.create(title: "The most recent video!", description: "See title", category: comedies, created_at: 1.day.ago)
     	expect(comedies.recent_videos.count).to eq(6)
    end
  end
end