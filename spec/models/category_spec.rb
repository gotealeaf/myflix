require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns the videos in reverse chronical order by created at" do
      cat = Category.create(name: "Comedy")
      v1 = Video.create(title: "Monk", description: "A show", created_at: 1.day.ago)
      v2 = Video.create(title: "Monk", description: "A show", created_at: 2.days.ago)
      v3 = Video.create(title: "Monk", description: "A show", created_at: 3.days.ago)
      v4 = Video.create(title: "Monk", description: "A show", created_at: 4.days.ago)
      v1.categories << cat
      v2.categories << cat
      v3.categories << cat
      v4.categories << cat
      expect(cat.recent_videos).to eq([v1, v2, v3, v4])
    end
    it "returns all videos if less than 6 videos" do
      cat = Category.create(name: "Comedy")
      v1 = Video.create(title: "Monk", description: "A show", created_at: 1.day.ago)
      v2 = Video.create(title: "Monk", description: "A show", created_at: 2.days.ago)
      v3 = Video.create(title: "Monk", description: "A show", created_at: 3.days.ago)
      v4 = Video.create(title: "Monk", description: "A show", created_at: 4.days.ago)
      v1.categories << cat
      v2.categories << cat
      v3.categories << cat
      v4.categories << cat
      expect(cat.recent_videos.count).to eq(4)
    end
    it "if more than 6 videos returns an array of most recent videos of only 6 videos" do
      cat = Category.create(name: "Comedy")
      v1 = Video.create(title: "Monk", description: "A show", created_at: 1.day.ago)
      v2 = Video.create(title: "Monk", description: "A show", created_at: 2.days.ago)
      v3 = Video.create(title: "Monk", description: "A show", created_at: 3.days.ago)
      v4 = Video.create(title: "Monk", description: "A show", created_at: 4.days.ago)
      v5 = Video.create(title: "Monk", description: "A show", created_at: 5.day.ago)
      v6 = Video.create(title: "Monk", description: "A show", created_at: 6.days.ago)
      v7 = Video.create(title: "Monk", description: "A show", created_at: 7.days.ago)
      v8 = Video.create(title: "Monk", description: "A show", created_at: 8.days.ago)
      v1.categories << cat
      v2.categories << cat
      v3.categories << cat
      v4.categories << cat
      v5.categories << cat
      v6.categories << cat
      v7.categories << cat
      v8.categories << cat
      expect(cat.recent_videos).to eq([v1, v2, v3, v4, v5, v6])
    end
    it "returns an empty array if no videos" do
      cat = Category.create(name: "Comedy")
      expect(cat.recent_videos).to eq([])
    end
  end
end
