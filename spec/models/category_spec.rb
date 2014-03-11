require 'spec_helper'

describe Category do 
  it { should have_many(:video_categories) }
  it { should have_many(:videos).through(:video_categories) }

  describe "#recent_videos" do
    it "returns the videos in reverse chronical order by created at" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "funny show")
      futurama.categories << comedies
      south_park.categories << comedies
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "funny show")
      futurama.categories << comedies
      south_park.categories << comedies
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "funny show")
      futurama1 = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park1 = Video.create(title: "South Park", description: "funny show")
      futurama2 = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park2 = Video.create(title: "South Park", description: "funny show")
      futurama3 = Video.create(title: "Futurama", description: "space travel show", created_at: 1.day.ago)
      south_park3 = Video.create(title: "South Park", description: "funny show")
      futurama.categories << comedies
      south_park.categories << comedies
      futurama1.categories << comedies
      south_park1.categories << comedies
      futurama2.categories << comedies
      south_park2.categories << comedies
      futurama3.categories << comedies
      south_park3.categories << comedies
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel show")
      south_park = Video.create(title: "South Park", description: "funny show")
      futurama1 = Video.create(title: "Futurama", description: "space travel show")
      south_park1 = Video.create(title: "South Park", description: "funny show")
      futurama2 = Video.create(title: "Futurama", description: "space travel show")
      south_park2 = Video.create(title: "South Park", description: "funny show")
      futurama3 = Video.create(title: "Futurama", description: "space travel show")
      south_park3 = Video.create(title: "South Park", description: "funny show", created_at: 1.day.ago)
      futurama.categories << comedies
      south_park.categories << comedies
      futurama1.categories << comedies
      south_park1.categories << comedies
      futurama2.categories << comedies
      south_park2.categories << comedies
      futurama3.categories << comedies
      south_park3.categories << comedies
      expect(comedies.recent_videos).not_to include(south_park3)
    end

    it "returns an empty array if the category does not have any videos" do
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end

  end
end