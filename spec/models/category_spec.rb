require 'spec_helper'

  describe Category do
   it { should have_many(:videos)}

    describe "#recent_videos" do
     it "returns the videos in reverse chronical order by created at" do
        comedies = Category.create(title: "comedies")
        futurama = Video.create(name: "Futurama", description: "space travel!",
        category: comedies, created_at: 1.day.ago)
        south_park = Video.create(name: "South Park", description: "crazy kids", category: comedies)
        expect(comedies.recent_videos).to eq([south_park, futurama])
     end
  
     it "returns all the video if there are less than 6 videos" do
        comedies = Category.create(title: "comedies")
        futurama = Video.create(name: "Futurama", description: "space travel!",
        category: comedies, created_at: 1.day.ago)
        south_park = Video.create(name: "South Park", description: "crazy kids", category: comedies)
        expect(comedies.recent_videos.count).to eq(2) 
     end
    it "returns 6 videos if there are more than 6 vidoes" do
        comedies = Category.create(title: "comedies")
        7.times {Video.create(name: "foo", description: "bar", category: comedies)}
        expect(comedies.recent_videos.count).to  eq(6)
    end
     it "returns the most recent 6 videos" do
        comedies = Category.create(title: "comedies")
        6.times {Video.create(name: "foo", description: "bar", category: comedies)}
        tonight_show = Video.create(name: "Tonight show", description: "talk show", category: comedies, created_at: 1.day.ago) 
     end
     it "returns an empty array if the category does not have any videos" do
        comedies = Category.create(title: "comedies")
        expect(comedies.recent_videos).to eq([])
    end
  end
  end
